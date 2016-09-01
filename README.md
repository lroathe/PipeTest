# PipeTest
Demonstrates various ways of using pipes between two processes with NSTask

Specifically, it shows how NSTask's waitUntilExit hangs if the process it's running fills the output pipe, and a simple solution to address the issue.
