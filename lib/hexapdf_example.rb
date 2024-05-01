# frozen_string_literal: true

require 'hexapdf'

# HexapdfExample
class HexapdfExample
  include PdfHandler::Utils

  def merge(file_paths, path_to_new_pdf)
    target = HexaPDF::Document.new
    file_paths.each do |file|
      pdf = HexaPDF::Document.open(file)
      pdf.pages.each do |page|
        target.pages << target.import(page)
      end
    end
    target.write(path_with_date(path_to_new_pdf), optimize: true)
  end

  def split(file_path, path_to_new_pdf, pages)
    target = HexaPDF::Document.new
    pdf = HexaPDF::Document.open(file_path)
    pdf.pages.to_a[pages].each do |page|
      target.pages << target.import(page)
    end
    target.write(path_with_date(path_to_new_pdf), optimize: true)
  end
end
