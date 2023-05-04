# get the output of sessionInfo() as a character vector
session_info <- capture.output(sessionInfo())
# write the output to a text file
writeLines(session_info, "session_info.txt")
