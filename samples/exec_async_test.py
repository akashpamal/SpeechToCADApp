import time

def delay_print():
    start_time = time.perf_counter()
    while time.perf_counter() - start_time < 2:
        pass
    print('This message is called first but delayed')


exec("delay_print()")
exec("print('hello there')")

"""
Conclusion: exec() is not an async method
"""