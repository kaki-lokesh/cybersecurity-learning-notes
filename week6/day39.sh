#!/bin/bash

# Parallel API
  With "concurrent.futures.ThreadPoolExecutor", multiple APIs can be queried simultaneously.
  Example: If you query four APIs sequentially, each taking 2 sec, the tool takes 8 sec min per target.
           Using concurrent.futures.ThreadPoolExecutor, query all four simultaneously (~2sec).
