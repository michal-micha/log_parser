## Log parser Ruby script

To call this script run following command from terminal:
```shell
./log_parser.rb <LOG_FILE_PATH>
```

## Possible improvements to be made:
- adding Zeitwerk to remove lots of code used for files requirements
- implementing validation of file's content (not just its extension)
- dividing log file to smaller files and parsing them in order if original file's size is too large
- extracting script to rake task and writing specs for that (true integration test - without any mocks and doubles)
- providing feedback on the process to end user (eg. "Processing file... [13%]")
- using single object (instead of 2 separate hashes) to hold information of total_views and unique views - at the cost of visibility 
- trying different sorting algorithms instead of Enumerable#sort_by and benchmarking them to choose one with best performance for our case
- allowing to use different formatter - which will prettify the output message
- allowing to use different logger or to save output directly into a file (instead of printing)
- extracting log parser logic to AWS lambda and invoke it via API Gateway to provide interface

(skipped because I've already spent more than 2.5h on this task, but I'd be happy to implement them if you wish)

