# Author: David Goodger
# Contact: goodger@users.sourceforge.net
# Revision: $Revision$
# Date: $Date$
# Copyright: This module has been placed in the public domain.

"""
Command-line and common processing for Docutils front-end tools.

Exports the following classes:

* `OptionParser`: Standard Docutils command-line processing.
* `Option`: Customized version of `optparse.Option`; validation support.
* `Values`: Runtime settings; objects are simple structs
  (``object.attribute``).  Supports cumulative list settings (attributes).
* `ConfigParser`: Standard Docutils config file processing.

Also exports the following functions:

* Option callbacks: `store_multiple`, `read_config_file`.
* Setting validators: `validate_encoding`,
  `validate_encoding_error_handler`,
  `validate_encoding_and_error_handler`, `validate_boolean`,
  `validate_threshold`, `validate_colon_separated_string_list`,
  `validate_dependency_file`.
* `make_paths_absolute`.
"""

__docformat__ = 'reStructuredText'

import os
import os.path
import sys
import types
import warnings
import ConfigParser as CP
import codecs
import docutils
try:
    import optparse
    from optparse import SUPPRESS_HELP
except ImportError:
    import optik as optparse
    from optik import SUPPRESS_HELP


def store_multiple(option, opt, value, parser, *args, **kwargs):
    """
    Store multiple values in `parser.values`.  (Option callback.)

    Store `None` for each attribute named in `args`, and store the value for
    each key (attribute name) in `kwargs`.
    """
    for attribute in args:
        setattr(parser.values, attribute, None)
    for key, value in kwargs.items():
        setattr(parser.values, key, value)

def read_config_file(option, opt, value, parser):
    """
    Read a configuration file during option processing.  (Option callback.)
    """
    try:
        new_settings = parser.get_config_file_settings(value)
    except ValueError, error:
        parser.error(error)
    parser.values.update(new_settings, parser)

def validate_encoding(setting, value, option_parser,
                      config_parser=None, config_section=None):
    try:
        codecs.lookup(value)
    except LookupError:
        raise (LookupError('setting "%s": unknown encoding: "%s"'
                           % (setting, value)),
               None, sys.exc_info()[2])
    return value

def validate_encoding_error_handler(setting, value, option_parser,
                                    config_parser=None, config_section=None):
    try:
        codecs.lookup_error(value)
    except AttributeError:              # prior to Python 2.3
        if value not in ('strict', 'ignore', 'replace', 'xmlcharrefreplace'):
            raise (LookupError(
                'unknown encoding error handler: "%s" (choices: '
                '"strict", "ignore", "replace", or "xmlcharrefreplace")' % value),
                   None, sys.exc_info()[2])
    except LookupError:
        raise (LookupError(
            'unknown encoding error handler: "%s" (choices: '
            '"strict", "ignore", "replace", "backslashreplace", '
            '"xmlcharrefreplace", and possibly others; see documentation for '
            'the Python ``codecs`` module)' % value),
               None, sys.exc_info()[2])
    return value

def validate_encoding_and_error_handler(
    setting, value, option_parser, config_parser=None, config_section=None):
    """
    Side-effect: if an error handler is included in the value, it is inserted
    into the appropriate place as if it was a separate setting/option.
    """
    if ':' in value:
        encoding, handler = value.split(':')
        validate_encoding_error_handler(
            setting + '_error_handler', handler, option_parser,
            config_parser, config_section)
        if config_parser:
            config_parser.set(config_section, setting + '_error_handler',
                              handler)
        else:
            setattr(option_parser.values, setting + '_error_handler', handler)
    else:
        encoding = value
    validate_encoding(setting, encoding, option_parser,
                      config_parser, config_section)
    return encoding

def validate_boolean(setting, value, option_parser,
                     config_parser=None, config_section=None):
    if isinstance(value, types.StringType):
        try:
            return option_parser.booleans[value.strip().lower()]
        except KeyError:
            raise (LookupError('unknown boolean value: "%s"' % value),
                   None, sys.exc_info()[2])
    return value

def validate_nonnegative_int(setting, value, option_parser,
                             config_parser=None, config_section=None):
    value = int(value)
    if value < 0:
        raise ValueError('negative value; must be positive or zero')
    return value

def validate_threshold(setting, value, option_parser,
                       config_parser=None, config_section=None):
    try:
        return int(value)
    except ValueError:
        try:
            return option_parser.thresholds[value.lower()]
        except (KeyError, AttributeError):
            raise (LookupError('unknown threshold: %r.' % value),
                   None, sys.exc_info[2])

def validate_colon_separated_string_list(
    setting, value, option_parser, config_parser=None, config_section=None):
    if isinstance(value, types.StringType):
        value = value.split(':')
    else:
        last = value.pop()
        value.extend(last.split(':'))
    return value

def validate_url_trailing_slash(
    setting, value, option_parser, config_parser=None, config_section=None):
    if not value:
        return './'
    elif value.endswith('/'):
        return value
    else:
        return value + '/'

def validate_dependency_file(
    setting, value, option_parser, config_parser=None, config_section=None):
    try:
        return docutils.utils.DependencyList(value)
    except IOError:
        return docutils.utils.DependencyList(None)

def make_paths_absolute(pathdict, keys, base_path=None):
    """
    Interpret filesystem path settings relative to the `base_path` given.

    Paths are values in `pathdict` whose keys are in `keys`.  Get `keys` from
    `OptionParser.relative_path_settings`.
    """
    if base_path is None:
        base_path = os.getcwd()
    for key in keys:
        if pathdict.has_key(key):
            value = pathdict[key]
            if isinstance(value, types.ListType):
                value = [make_one_path_absolute(base_path, path)
                         for path in value]
            elif value:
                value = make_one_path_absolute(base_path, value)
            pathdict[key] = value

def make_one_path_absolute(base_path, path):
    return os.path.abspath(os.path.join(base_path, path))


class Values(optparse.Values):

    """
    Updates list attributes by extension rather than by replacement.
    Works in conjunction with the `OptionParser.lists` instance attribute.
    """

    def __init__(self, *args, **kwargs):
        optparse.Values.__init__(self, *args, **kwargs)
        if (not hasattr(self, 'record_dependencies')
            or self.record_dependencies is None):
            # Set up dependency list, in case it is needed.
            self.record_dependencies = docutils.utils.DependencyList()

    def update(self, other_dict, option_parser):
        if isinstance(other_dict, Values):
            other_dict = other_dict.__dict__
        other_dict = other_dict.copy()
        for setting in option_parser.lists.keys():
            if (hasattr(self, setting) and other_dict.has_key(setting)):
                value = getattr(self, setting)
                if value:
                    value += other_dict[setting]
                    del other_dict[setting]
        self._update_loose(other_dict)


class Option(optparse.Option):

    ATTRS = optparse.Option.ATTRS + ['validator', 'overrides']

    def process(self, opt, value, values, parser):
        """
        Call the validator function on applicable settings and
        evaluate the 'overrides' option.
        Extends `optparse.Option.process`.
        """
        result = optparse.Option.process(self, opt, value, values, parser)
        setting = self.dest
        if setting:
            if self.validator:
                value = getattr(values, setting)
                try:
                    new_value = self.validator(setting, value, parser)
                except Exception, error:
                    raise (optparse.OptionValueError(
                        'Error in option "%s":\n    %s: %s'
                        % (opt, error.__class__.__name__, error)),
                           None, sys.exc_info()[2])
                setattr(values, setting, new_value)
            if self.overrides:
                setattr(values, self.overrides, None)
        return result


class OptionParser(optparse.OptionParser, docutils.SettingsSpec):

    """
    Parser for command-line and library use.  The `settings_spec`
    specification here and in other Docutils components are merged to build
    the set of command-line options and runtime settings for this process.

    Common settings (defined below) and component-specific settings must not
    conflict.  Short options are reserved for common settings, and components
    are restrict to using long options.
    """

    standard_config_files = [
        '/etc/docutils.conf',           # system-wide
        './docutils.conf',              # project-specific
        '~/.docutils']                  # user-specific
    """Docutils configuration files, using ConfigParser syntax.  Filenames
    will be tilde-expanded later.  Later files override earlier ones."""

    threshold_choices = 'info 1 warning 2 error 3 severe 4 none 5'.split()
    """Possible inputs for for --report and --halt threshold values."""

    thresholds = {'info': 1, 'warning': 2, 'error': 3, 'severe': 4, 'none': 5}
    """Lookup table for --report and --halt threshold values."""

    booleans={'1': 1, 'on': 1, 'yes': 1, 'true': 1,
              '0': 0, 'off': 0, 'no': 0, 'false': 0, '': 0}
    """Lookup table for boolean configuration file settings."""

    if hasattr(codecs, 'backslashreplace_errors'):
        default_error_encoding_error_handler = 'backslashreplace'
    else:
        default_error_encoding_error_handler = 'replace'

    settings_spec = (
        'General Docutils Options',
        None,
        (('Specify the document title as metadata (not part of the document '
          'body).  Overrides a document-provided title.  There is no default.',
          ['--title'], {}),
         ('Include a "Generated by Docutils" credit and link at the end '
          'of the document.',
          ['--generator', '-g'], {'action': 'store_true',
                                  'validator': validate_boolean}),
         ('Do not include a generator credit.',
          ['--no-generator'], {'action': 'store_false', 'dest': 'generator'}),
         ('Include the date at the end of the document (UTC).',
          ['--date', '-d'], {'action': 'store_const', 'const': '%Y-%m-%d',
                             'dest': 'datestamp'}),
         ('Include the time & date at the end of the document (UTC).',
          ['--time', '-t'], {'action': 'store_const',
                             'const': '%Y-%m-%d %H:%M UTC',
                             'dest': 'datestamp'}),
         ('Do not include a datestamp of any kind.',
          ['--no-datestamp'], {'action': 'store_const', 'const': None,
                               'dest': 'datestamp'}),
         ('Include a "View document source" link (relative to destination).',
          ['--source-link', '-s'], {'action': 'store_true',
                                    'validator': validate_boolean}),
         ('Use the supplied <URL> verbatim for a "View document source" '
          'link; implies --source-link.',
          ['--source-url'], {'metavar': '<URL>'}),
         ('Do not include a "View document source" link.',
          ['--no-source-link'],
          {'action': 'callback', 'callback': store_multiple,
           'callback_args': ('source_link', 'source_url')}),
         ('Enable backlinks from section headers to table of contents '
          'entries.  This is the default.',
          ['--toc-entry-backlinks'],
          {'dest': 'toc_backlinks', 'action': 'store_const', 'const': 'entry',
           'default': 'entry'}),
         ('Enable backlinks from section headers to the top of the table of '
          'contents.',
          ['--toc-top-backlinks'],
          {'dest': 'toc_backlinks', 'action': 'store_const', 'const': 'top'}),
         ('Disable backlinks to the table of contents.',
          ['--no-toc-backlinks'],
          {'dest': 'toc_backlinks', 'action': 'store_false'}),
         ('Enable backlinks from footnotes and citations to their '
          'references.  This is the default.',
          ['--footnote-backlinks'],
          {'action': 'store_true', 'default': 1,
           'validator': validate_boolean}),
         ('Disable backlinks from footnotes and citations.',
          ['--no-footnote-backlinks'],
          {'dest': 'footnote_backlinks', 'action': 'store_false'}),
         ('Disable Docutils section numbering',
          ['--no-section-numbering'],
          {'action': 'store_false', 'dest': 'sectnum_xform',
           'default': 1, 'validator': validate_boolean}),
         ('Set verbosity threshold; report system messages at or higher than '
          '<level> (by name or number: "info" or "1", warning/2, error/3, '
          'severe/4; also, "none" or "5").  Default is 2 (warning).',
          ['--report', '-r'], {'choices': threshold_choices, 'default': 2,
                               'dest': 'report_level', 'metavar': '<level>',
                               'validator': validate_threshold}),
         ('Report all system messages, info-level and higher.  (Same as '
          '"--report=info".)',
          ['--verbose', '-v'], {'action': 'store_const', 'const': 1,
                                'dest': 'report_level'}),
         ('Do not report any system messages.  (Same as "--report=none".)',
          ['--quiet', '-q'], {'action': 'store_const', 'const': 5,
                              'dest': 'report_level'}),
         ('Set the threshold (<level>) at or above which system messages are '
          'converted to exceptions, halting execution immediately by '
          'exiting (or propagating the exception if --traceback set).  '
          'Levels as in --report.  Default is 4 (severe).',
          ['--halt'], {'choices': threshold_choices, 'dest': 'halt_level',
                       'default': 4, 'metavar': '<level>',
                       'validator': validate_threshold}),
         ('Same as "--halt=info": halt processing at the slightest problem.',
          ['--strict'], {'action': 'store_const', 'const': 'info',
                         'dest': 'halt_level'}),
         ('Enable a non-zero exit status for normal exit if non-halting '
          'system messages (at or above <level>) were generated.  Levels as '
          'in --report.  Default is 5 (disabled).  Exit status is the maximum '
          'system message level plus 10 (11 for INFO, etc.).',
          ['--exit-status'], {'choices': threshold_choices,
                              'dest': 'exit_status_level',
                              'default': 5, 'metavar': '<level>',
                              'validator': validate_threshold}),
         ('Report debug-level system messages and generate diagnostic output.',
          ['--debug'], {'action': 'store_true', 'validator': validate_boolean}),
         ('Do not report debug-level system messages or generate diagnostic '
          'output.',
          ['--no-debug'], {'action': 'store_false', 'dest': 'debug'}),
         ('Send the output of system messages (warnings) to <file>.',
          ['--warnings'], {'dest': 'warning_stream', 'metavar': '<file>'}),
         ('Enable Python tracebacks when halt-level system messages and '
          'other exceptions occur.  Useful for debugging, and essential for '
          'issue reports.',
          ['--traceback'], {'action': 'store_true', 'default': None,
                            'validator': validate_boolean}),
         ('Disable Python tracebacks when errors occur; report just the error '
          'instead.  This is the default.',
          ['--no-traceback'], {'dest': 'traceback', 'action': 'store_false'}),
         ('Specify the encoding of input text.  Default is locale-dependent.  '
          'Optionally also specify the error handler for undecodable '
          'characters, after a colon (":"); default is "strict".  (See '
          '"--intput-encoding-error-handler".)',
          ['--input-encoding', '-i'],
          {'metavar': '<name[:handler]>',
           'validator': validate_encoding_and_error_handler}),
         ('Specify the error handler for undecodable characters in '
          'the input.  Acceptable values include "strict", "ignore", and '
          '"replace".  Default is "strict".  '
          'Usually specified as part of --input-encoding.',
          ['--input-encoding-error-handler'],
          {'default': 'strict', 'validator': validate_encoding_error_handler}),
         ('Specify the text encoding for output.  Default is UTF-8.  '
          'Optionally also specify the error handler for unencodable '
          'characters, after a colon (":"); default is "strict".  (See '
          '"--output-encoding-error-handler".)',
          ['--output-encoding', '-o'],
          {'metavar': '<name[:handler]>', 'default': 'utf-8',
           'validator': validate_encoding_and_error_handler}),
         ('Specify the error handler for unencodable characters in '
          'the output.  Acceptable values include "strict", "ignore", '
          '"replace", "xmlcharrefreplace", and '
          '"backslashreplace" (in Python 2.3+).  Default is "strict".  '
          'Usually specified as part of --output-encoding.',
          ['--output-encoding-error-handler'],
          {'default': 'strict', 'validator': validate_encoding_error_handler}),
         ('Specify the text encoding for error output.  Default is ASCII.  '
          'Optionally also specify the error handler for unencodable '
          'characters, after a colon (":"); default is "%s".  (See '
          '"--output-encoding-error-handler".)'
          % default_error_encoding_error_handler,
          ['--error-encoding', '-e'],
          {'metavar': '<name[:handler]>', 'default': 'ascii',
           'validator': validate_encoding_and_error_handler}),
         ('Specify the error handler for unencodable characters in '
          'error output.  See --output-encoding-error-handler for acceptable '
          'values.  Default is "%s".  Usually specified as part of '
          '--error-encoding.' % default_error_encoding_error_handler,
          ['--error-encoding-error-handler'],
          {'default': default_error_encoding_error_handler,
           'validator': validate_encoding_error_handler}),
         ('Specify the language of input text (ISO 639 2-letter identifier).'
          '  Default is "en" (English).',
          ['--language', '-l'], {'dest': 'language_code', 'default': 'en',
                                 'metavar': '<name>'}),
         ('Write dependencies (caused e.g. by file inclusions) to '
          '<file>.  Useful in conjunction with programs like "make".',
          ['--record-dependencies'],
          {'metavar': '<file>', 'validator': validate_dependency_file,
           'default': None}),           # default set in Values class
         ('Read configuration settings from <file>, if it exists.',
          ['--config'], {'metavar': '<file>', 'type': 'string',
                         'action': 'callback', 'callback': read_config_file}),
         ("Show this program's version number and exit.",
          ['--version', '-V'], {'action': 'version'}),
         ('Show this help message and exit.',
          ['--help', '-h'], {'action': 'help'}),
         # Typically not useful for non-programmatical use.
         (SUPPRESS_HELP, ['--id-prefix'], {'default': ''}),
         (SUPPRESS_HELP, ['--auto-id-prefix'], {'default': 'id'}),
         # Hidden options, for development use only:
         (SUPPRESS_HELP, ['--dump-settings'], {'action': 'store_true'}),
         (SUPPRESS_HELP, ['--dump-internals'], {'action': 'store_true'}),
         (SUPPRESS_HELP, ['--dump-transforms'], {'action': 'store_true'}),
         (SUPPRESS_HELP, ['--dump-pseudo-xml'], {'action': 'store_true'}),
         (SUPPRESS_HELP, ['--expose-internal-attribute'],
          {'action': 'append', 'dest': 'expose_internals',
           'validator': validate_colon_separated_string_list}),
         (SUPPRESS_HELP, ['--strict-visitor'], {'action': 'store_true'}),
         ))
    """Runtime settings and command-line options common to all Docutils front
    ends.  Setting specs specific to individual Docutils components are also
    used (see `populate_from_components()`)."""

    settings_defaults = {'_disable_config': None,
                         '_source': None,
                         '_destination': None,}
    """Defaults for settings that don't have command-line option equivalents."""

    relative_path_settings = ('warning_stream',)

    config_section = 'general'

    version_template = ('%%prog (Docutils %s [%s])'
                        % (docutils.__version__, docutils.__version_details__))
    """Default version message."""

    def __init__(self, components=(), defaults=None, read_config_files=None,
                 *args, **kwargs):
        """
        `components` is a list of Docutils components each containing a
        ``.settings_spec`` attribute.  `defaults` is a mapping of setting
        default overrides.
        """

        self.lists = {}
        """Set of list-type settings."""

        optparse.OptionParser.__init__(
            self, option_class=Option, add_help_option=None,
            formatter=optparse.TitledHelpFormatter(width=78),
            *args, **kwargs)
        if not self.version:
            self.version = self.version_template
        # Make an instance copy (it will be modified):
        self.relative_path_settings = list(self.relative_path_settings)
        self.components = (self,) + tuple(components)
        self.populate_from_components(self.components)
        self.set_defaults(**(defaults or {}))
        if read_config_files and not self.defaults['_disable_config']:
            try:
                config_settings = self.get_standard_config_settings()
            except ValueError, error:
                self.error(error)
            self.set_defaults(**config_settings.__dict__)

    def populate_from_components(self, components):
        """
        For each component, first populate from the `SettingsSpec.settings_spec`
        structure, then from the `SettingsSpec.settings_defaults` dictionary.
        After all components have been processed, check for and populate from
        each component's `SettingsSpec.settings_default_overrides` dictionary.
        """
        for component in components:
            if component is None:
                continue
            settings_spec = component.settings_spec
            self.relative_path_settings.extend(
                component.relative_path_settings)
            for i in range(0, len(settings_spec), 3):
                title, description, option_spec = settings_spec[i:i+3]
                if title:
                    group = optparse.OptionGroup(self, title, description)
                    self.add_option_group(group)
                else:
                    group = self        # single options
                for (help_text, option_strings, kwargs) in option_spec:
                    option = group.add_option(help=help_text, *option_strings,
                                              **kwargs)
                    if kwargs.get('action') == 'append':
                        self.lists[option.dest] = 1
                if component.settings_defaults:
                    self.defaults.update(component.settings_defaults)
        for component in components:
            if component and component.settings_default_overrides:
                self.defaults.update(component.settings_default_overrides)

    def get_standard_config_files(self):
        """Return list of config files, from environment or standard."""
        try:
            config_files = os.environ['DOCUTILSCONFIG'].split(os.pathsep)
        except KeyError:
            config_files = self.standard_config_files
        return [os.path.expanduser(f) for f in config_files if f.strip()]

    def get_standard_config_settings(self):
        settings = Values()
        for filename in self.get_standard_config_files():
            settings.update(self.get_config_file_settings(filename), self)
        return settings

    def get_config_file_settings(self, config_file):
        """Returns a dictionary containing appropriate config file settings."""
        parser = ConfigParser()
        parser.read(config_file, self)
        base_path = os.path.dirname(config_file)
        applied = {}
        settings = Values()
        for component in self.components:
            if not component:
                continue
            for section in (tuple(component.config_section_dependencies or ())
                            + (component.config_section,)):
                if applied.has_key(section):
                    continue
                applied[section] = 1
                settings.update(parser.get_section(section), self)
        make_paths_absolute(
            settings.__dict__, self.relative_path_settings, base_path)
        return settings.__dict__

    def check_values(self, values, args):
        """Store positional arguments as runtime settings."""
        values._source, values._destination = self.check_args(args)
        make_paths_absolute(values.__dict__, self.relative_path_settings,
                            os.getcwd())
        return values

    def check_args(self, args):
        source = destination = None
        if args:
            source = args.pop(0)
            if source == '-':           # means stdin
                source = None
        if args:
            destination = args.pop(0)
            if destination == '-':      # means stdout
                destination = None
        if args:
            self.error('Maximum 2 arguments allowed.')
        if source and source == destination:
            self.error('Do not specify the same file for both source and '
                       'destination.  It will clobber the source file.')
        return source, destination

    def get_default_values(self):
        """Needed to get custom `Values` instances."""
        return Values(self.defaults)

    def get_option_by_dest(self, dest):
        """
        Get an option by its dest.

        If you're supplying a dest which is shared by several options,
        it is undefined which option of those is returned.

        A KeyError is raised if there is no option with the supplied
        dest.
        """
        for group in self.option_groups + [self]:
            for option in group.option_list:
                if option.dest == dest:
                    return option
        raise KeyError('No option with dest == %r.' % dest)


class ConfigParser(CP.ConfigParser):

    old_settings = {
        'pep_stylesheet': ('pep_html writer', 'stylesheet'),
        'pep_stylesheet_path': ('pep_html writer', 'stylesheet_path'),
        'pep_template': ('pep_html writer', 'template')}
    """{old setting: (new section, new setting)} mapping, used by
    `handle_old_config`, to convert settings from the old [options] section."""

    old_warning = """
The "[option]" section is deprecated.  Support for old-format configuration
files may be removed in a future Docutils release.  Please revise your
configuration files.  See <http://docutils.sf.net/docs/user/config.html>,
section "Old-Format Configuration Files".
"""

    def read(self, filenames, option_parser):
        if type(filenames) in (types.StringType, types.UnicodeType):
            filenames = [filenames]
        for filename in filenames:
            CP.ConfigParser.read(self, filename)
            if self.has_section('options'):
                self.handle_old_config(filename)
            self.validate_settings(filename, option_parser)

    def handle_old_config(self, filename):
        warnings.warn_explicit(self.old_warning, ConfigDeprecationWarning,
                               filename, 0)
        options = self.get_section('options')
        if not self.has_section('general'):
            self.add_section('general')
        for key, value in options.items():
            if self.old_settings.has_key(key):
                section, setting = self.old_settings[key]
                if not self.has_section(section):
                    self.add_section(section)
            else:
                section = 'general'
                setting = key
            if not self.has_option(section, setting):
                self.set(section, setting, value)
        self.remove_section('options')

    def validate_settings(self, filename, option_parser):
        """
        Call the validator function and implement overrides on all applicable
        settings.
        """
        for section in self.sections():
            for setting in self.options(section):
                try:
                    option = option_parser.get_option_by_dest(setting)
                except KeyError:
                    continue
                if option.validator:
                    value = self.get(section, setting, raw=1)
                    try:
                        new_value = option.validator(
                            setting, value, option_parser,
                            config_parser=self, config_section=section)
                    except Exception, error:
                        raise (ValueError(
                            'Error in config file "%s", section "[%s]":\n'
                            '    %s: %s\n        %s = %s'
                            % (filename, section, error.__class__.__name__,
                               error, setting, value)), None, sys.exc_info()[2])
                    self.set(section, setting, new_value)
                if option.overrides:
                    self.set(section, option.overrides, None)

    def optionxform(self, optionstr):
        """
        Transform '-' to '_' so the cmdline form of option names can be used.
        """
        return optionstr.lower().replace('-', '_')

    def get_section(self, section):
        """
        Return a given section as a dictionary (empty if the section
        doesn't exist).
        """
        section_dict = {}
        if self.has_section(section):
            for option in self.options(section):
                section_dict[option] = self.get(section, option, raw=1)
        return section_dict


class ConfigDeprecationWarning(DeprecationWarning):
    """Warning for deprecated configuration file features."""
