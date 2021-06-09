import asyncio

async def tcp_echo_client(message):
    reader, writer = await asyncio.open_connection(
        '127.0.0.1', 4567)

    # reader, writer = await asyncio.open_connection(
    #     '127.0.0.1', 4567)

    print(f'Send: {message!r}')
    writer.write(message.encode())

    data = await reader.read(1024)
    print(f'Received message: {data.decode()!r}')

    print('Close the connection')
    writer.close()

asyncio.run(tcp_echo_client('print("hello there")'))