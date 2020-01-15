# frozen_string_literal: true

# Handles documenting end to end scenarios adding text and images
class Document
  class << self
    attr_accessor :current_feature

    # @return [String] Folder in which scenarios are placed
    def doc_folder
      'manual'
    end

    # Save screenshot on page
    def page(browser, name)
      file_name = name.tr(' ', '_').snakecase
      relative_path = File.join('img', "#{file_name}.png")
      full_file_name = File.join(doc_folder, relative_path)
      browser.screenshot.save full_file_name
      add_text_to_file "![#{name}](#{relative_path})"
    end

    def step(text)
      add_text_to_file "### #{text}"
    end

    def scenario(text)
      add_text_to_file "## Scenario: #{text}"
    end

    # Document feature if it's not the current one
    def feature(feature)
      return unless current_feature != feature.name
      add_text_to_file "# Feature: #{feature.name}"
      add_text_to_file feature.description
      self.current_feature = feature.name
    end

    def add_text_to_file(text)
      File.open(File.join(doc_folder, 'training.md'), 'a') do |file|
        file.puts text
        file.puts ''
      end
    end
  end
end

require 'fileutils'
FileUtils.mkdir_p File.join Document.doc_folder, 'img'
