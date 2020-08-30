# frozen_string_literal: true

class LogFileValidator
  FILE_SIZE_LIMIT = 1_048_576

  def valid?(log_file)
    return false if file_has_invalid_extension?(log_file) || file_is_too_large?(log_file)

    true
  end

  private

  # Validating of file's extension of course is not enough to make sure that file has correct content,
  # but for purpose of the task, simpler solution's been used
  def file_has_invalid_extension?(log_file)
    !log_file.match?(/\.log/)
  end

  # Size limit's been decreased to allow for easier testing of failed condition
  def file_is_too_large?(log_file)
    File.size(log_file) >= FILE_SIZE_LIMIT
  end
end
