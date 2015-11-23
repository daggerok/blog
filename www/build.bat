@echo off

call npm run dependencies
call npm run deploy
call npm run win-test
