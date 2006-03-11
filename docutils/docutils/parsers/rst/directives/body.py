# Author: David Goodger
# Contact: goodger@python.org
# Revision: $Revision$
# Date: $Date$
# Copyright: This module has been placed in the public domain.

"""
Directives for additional body elements.

See `docutils.parsers.rst.directives` for API details.
"""

__docformat__ = 'reStructuredText'


import sys
from docutils import nodes
from docutils.parsers.rst import Directive
from docutils.parsers.rst import directives
from docutils.parsers.rst.roles import set_classes


class BaseTopic(Directive):

    required_arguments = 1
    optional_arguments = 0
    final_argument_whitespace = True
    option_spec = {'class': directives.class_option}
    has_content = True

    # Must be set in subclasses.
    node_class = None

    def run(self):
        if not (self.state_machine.match_titles
                or isinstance(self.state_machine.node, nodes.sidebar)):
            error = self.state_machine.reporter.error(
                'The "%s" directive may not be used within topics or body '
                'elements.' % self.name, nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [error]
        if not self.content:
            warning = self.state_machine.reporter.warning(
                'Content block expected for the "%s" directive; none found.'
                % self.name, nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [warning]
        title_text = self.arguments[0]
        textnodes, messages = self.state.inline_text(title_text, self.lineno)
        titles = [nodes.title(title_text, '', *textnodes)]
        # Sidebar uses this code.
        if self.options.has_key('subtitle'):
            textnodes, more_messages = self.state.inline_text(
                self.options['subtitle'], self.lineno)
            titles.append(nodes.subtitle(self.options['subtitle'], '',
                                         *textnodes))
            messages.extend(more_messages)
        text = '\n'.join(self.content)
        node = self.node_class(text, *(titles + messages))
        node['classes'] += self.options.get('class', [])
        if text:
            self.state.nested_parse(self.content, self.content_offset, node)
        return [node]


class Topic(BaseTopic):

    node_class = nodes.topic


class Sidebar(BaseTopic):

    node_class = nodes.sidebar

    option_spec = BaseTopic.option_spec.copy()
    option_spec['subtitle'] = directives.unchanged_required

    def run(self):
        if isinstance(self.state_machine.node, nodes.sidebar):
            error = self.state_machine.reporter.error(
                'The "%s" directive may not be used within a sidebar element.'
                % self.name, nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [error]
        return BaseTopic.run(self)


class LineBlock(Directive):

    option_spec = {'class': directives.class_option}
    has_content = True

    def run(self):
        if not self.content:
            warning = self.state_machine.reporter.warning(
                'Content block expected for the "%s" directive; none found.'
                % self.name, nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [warning]
        block = nodes.line_block(classes=self.options.get('class', []))
        node_list = [block]
        for line_text in self.content:
            text_nodes, messages = self.state.inline_text(
                line_text.strip(), self.lineno + self.content_offset)
            line = nodes.line(line_text, '', *text_nodes)
            if line_text.strip():
                line.indent = len(line_text) - len(line_text.lstrip())
            block += line
            node_list.extend(messages)
            self.content_offset += 1
        self.state.nest_line_block_lines(block)
        return node_list


class ParsedLiteral(Directive):

    option_spec = {'class': directives.class_option}
    has_content = True

    def run(self):
        set_classes(self.options)
        if not self.content:
            warning = self.state_machine.reporter.warning(
                'Content block expected for the "%s" directive; none found.'
                % self.name, nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [warning]
        text = '\n'.join(self.content)
        text_nodes, messages = self.state.inline_text(text, self.lineno)
        node = nodes.literal_block(text, '', *text_nodes, **self.options)
        node.line = self.content_offset + 1
        return [node] + messages


class Rubric(Directive):

    required_arguments = 1
    optional_arguments = 0
    final_argument_whitespace = True
    option_spec = {'class': directives.class_option}

    def run(self):
        set_classes(self.options)
        rubric_text = self.arguments[0]
        textnodes, messages = self.state.inline_text(rubric_text, self.lineno)
        rubric = nodes.rubric(rubric_text, '', *textnodes, **self.options)
        return [rubric] + messages


class BlockQuote(Directive):

    has_content = True
    classes = []

    def run(self):
        block_quote, messages = self.state.block_quote(
            self.content, self.content_offset)
        block_quote['classes'] += self.classes
        return [block_quote] + messages


class Epigraph(BlockQuote):

    classes = ['epigraph']


class Highlights(BlockQuote):

    classes = ['highlights']


class PullQuote(BlockQuote):

    classes = ['pull-quote']


class Compound(Directive):

    option_spec = {'class': directives.class_option}
    has_content = True

    def run(self):
        text = '\n'.join(self.content)
        if not text:
            error = self.state_machine.reporter.error(
                'The "%s" directive is empty; content required.' % name,
                nodes.literal_block(block_text, block_text), line=lineno)
            return [error]
        node = nodes.compound(text)
        node['classes'] += self.options.get('class', [])
        self.state.nested_parse(self.content, self.content_offset, node)
        return [node]


class Container(Directive):

    required_arguments = 0
    optional_arguments = 1
    final_argument_whitespace = True
    has_content = True

    def run(self):
        text = '\n'.join(self.content)
        if not text:
            error = self.state_machine.reporter.error(
                'The "%s" directive is empty; content required.' % self.name,
                nodes.literal_block(self.block_text, self.block_text),
                line=self.lineno)
            return [error]
        try:
            if self.arguments:
                classes = directives.class_option(self.arguments[0])
            else:
                classes = []
        except ValueError:
            error = self.state_machine.reporter.error(
                'Invalid class attribute value for "%s" directive: "%s".'
                % (self.name, self.arguments[0]), nodes.literal_block(
                self.block_text, self.block_text), line=self.lineno)
            return [error]
        node = nodes.container(text)
        node['classes'].extend(classes)
        self.state.nested_parse(self.content, self.content_offset, node)
        return [node]