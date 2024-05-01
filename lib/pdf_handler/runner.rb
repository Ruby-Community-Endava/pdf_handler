# frozen_string_literal: true

module PdfHandler
  # PdfHandler::Runner
  class Runner
    DEFAULT_TOOL = 'qpdf'
    BENCHMARK_TIMES = 10

    attr_reader :tool, :args, :benchmark, :example

    EXAMPLES = {
      'qpdf' => {
        merge: [
          ['resources/full_doc.pdf 1-z', 'resources/full_doc_5_pages.pdf 1-z', 'resources/full_slides.pdf 1-z'],
          'resources/merged.pdf'
        ]
      },
      'docsplit' => {
        merge: [
          ['resources/full_doc.pdf', 'resources/full_doc_5_pages.pdf', 'resources/full_slides.pdf'],
          'resources/merged.pdf'
        ],
        split: [
          'resources/full_doc.pdf',
          3..10
        ]
      },
      'hexapdf' => {
        merge: [
          ['resources/full_doc.pdf', 'resources/full_doc_5_pages.pdf', 'resources/full_slides.pdf'],
          'resources/merged.pdf'
        ],
        split: [
          'resources/full_doc.pdf',
          'resources/splitted.pdf',
          3..10
        ]
      }
    }.freeze

    def initialize
      @tool = DEFAULT_TOOL
      @args = nil
      @benchmark = true
      @example = true
    end

    def with(tool, example = true, benchmark = true, *args) # rubocop:disable Style/OptionalBooleanParameter
      @tool = tool.to_s
      @benchmark = benchmark
      @example = example
      @args = args.empty? ? nil : args
      self
    end

    def perform(action, *params)
      execute(action, *params) and return unless benchmark

      bm = Benchmark.bmbm do |x|
        x.report("#{action}:") { BENCHMARK_TIMES.times { execute(action, *params) } }
      end

      MemoryProfiler.report do
        BENCHMARK_TIMES.times { execute(action, *params) }
      end.pretty_print(to_file: "#{tool}_#{action}_memory_report.txt")
      puts "\n"
      bm
    end

    private

    def execute(action, *params)
      inner_params = example ? EXAMPLES[tool][action] : params
      Object.const_get("#{tool.capitalize}Example").new(*args).__send__(action, *inner_params)
    end
  end
end
