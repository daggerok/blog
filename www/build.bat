@echo off

call npm run clean
call npm run fetch
call npm run gulp
call npm test
