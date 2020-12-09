#!/bin/bash

date=$(date "+%Y-%m-%d %H:%M:%S")
git add .
git commit -m "update 测试ci $date"
git push