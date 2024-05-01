# frozen_string_literal: true

require 'logger'
require 'benchmark'
require 'benchmark/memory'
require 'memory_profiler'

require(RbConfig::CONFIG['target_os'] == 'mingw32' ? 'win32/open3' : 'open3')
require_relative 'pdf_handler/utils'
require_relative 'hexapdf_example'
require_relative 'docsplit_example'
require_relative 'qpdf_example'
require_relative 'pdf_handler/runner'

# PdfHandler
module PdfHandler; end
