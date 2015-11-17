@echo off

call npm run dependencies
call npm run clean
call npm run gulp
call npm run win-test
