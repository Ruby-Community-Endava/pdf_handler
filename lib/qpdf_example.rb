# frozen_string_literal: true

require 'digest/md5' # just for testing purposes

# QpdfExample
class QpdfExample
  include PdfHandler::Utils

  EXE_NAME = 'qpdf'

  def initialize(execute_path = nil)
    @exe_path = execute_path || find_binary_path(EXE_NAME)
    raise "Location of #{EXE_NAME} unknown" if @exe_path.empty?
    raise "Bad location of #{EXE_NAME}'s path" unless File.exist?(@exe_path)
    raise "#{EXE_NAME} is not executable" unless File.executable?(@exe_path)
  end

  def unlock(source_file, unlocked_file)
    command = "#{@exe_path} --decrypt #{source_file} #{unlocked_file}"
    Open3.popen3(command) do |_stdin, _stdout, stderr|
      stderr.read
    end
  rescue Exception => e # rubocop:disable Lint/RescueException
    raise "Failed to execute:\n#{command}\nError: #{e}"
  end

  def lock(source_file, locked_file, user_password, owner_password, key_length = 40)
    command = "#{@exe_path} --encrypt #{user_password} #{owner_password} #{key_length} -- #{source_file} #{locked_file}"
    Open3.popen3(command) do |_stdin, _stdout, stderr|
      stderr.read
    end
  rescue Exception => e # rubocop:disable Lint/RescueException
    raise "Failed to execute:\n#{command}\nError: #{e}"
  end

  # file_paths = ['resources/full_doc.pdf 1-z', 'resources/full_doc_5_pages.pdf 1-z', 'resources/full_slides.pdf 1-z']
  def merge(file_paths, path_to_new_pdf)
    command = "#{@exe_path} --empty --pages #{file_paths.join(' ')} -- #{path_with_date path_to_new_pdf}"
    Open3.popen3(command) do |_stdin, _stdout, stderr|
      stderr.read
    end
  rescue Exception => e # rubocop:disable Lint/RescueException
    raise "Failed to execute:\n#{command}\nError: #{e}"
  end
end
