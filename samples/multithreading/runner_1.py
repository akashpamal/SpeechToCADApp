import concurrent.futures
import requests
import threading
import time


items_to_print = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        executor.map(print, items_to_print)
