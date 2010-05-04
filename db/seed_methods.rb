module SeedMethods  
  require 'progressbar'

  # Display a progress bar. The block variable is the progress bar object.
  # Presumes that we will increment for each line in the input file.
  def progress(phrase, count, &block)
    # Create the progress bar.
    progress_bar = ProgressBar.new(phrase, count)
    # Let the block do its work.
    yield progress_bar
    # Done with the progress bar.
    progress_bar.finish    
  end

  # Determine number of rows in file.
  def get_num_lines(path)
    num_lines = 0
    file = File.open(path, 'r')
    file.each_line { |l| num_lines += 1 }
    num_lines
  end
end