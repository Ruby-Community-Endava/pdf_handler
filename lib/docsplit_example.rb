# frozen_string_literal: true

require 'combine_pdf'
require 'docsplit'

# DocsplitExample
class DocsplitExample
  include PdfHandler::Utils

  def merge(file_paths, path_to_new_pdf)
    pdf = CombinePDF.new
    file_paths.each do |file|
      pdf << CombinePDF.load(file) # one way to combine, very fast.
    end
    pdf.save path_with_date(path_to_new_pdf)
  end

  # split('resources/full_doc.pdf', 3..10
  def split(file_path, pages)
    Docsplit.extract_pages(file_path, pages: pages)
  end
end
