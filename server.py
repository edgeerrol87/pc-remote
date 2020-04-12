# first of all import the socket library
import socket
import pyautogui
import io

# next create a socket object
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("Socket successfully created")


# reserve a port on your computer in our
# case it is 12345 but it can byte anything
port = 20001

# Next bind to the port
# we have not typed any ip in the ip field
# instead we have inputted an empty string
# this makes the server listen to requests
# coming from other computers on the network

s.bind(('', port))
print("socket binded to %s" % port)

# put the socket into listening mode

s.listen(10)
print("socket is listening")

if s is None:
    print('could not open socket')

# a forever loop until we interrupt it or
# an error occurs

pyautogui.PAUSE = 0.0
pyautogui.FAILSAFE = False

terminate = False

while True and terminate is False:

    # Establish connection with client.
    c, addr = s.accept()
    # print('Got connection from', addr)

    data = str(c.recv(100), 'utf-8').split(';')
    # send a thank you message to the client.

    if data[0] != "" and data[0][0] == "x":
        for each in data:
            coord = each.split(",")
            try:
                pyautogui.move(round(float(coord[0][2:]) / 7, 0), round(float(coord[1][2:]) / 7, 0),
                               pyautogui.MINIMUM_DURATION / 10)
            except:
                pass
    elif data[0] == "click":
        pyautogui.click(button="left")
    elif data[0] == "rclick":
        pyautogui.click(button="right")
    elif data[0] == "getScreen":
        im = pyautogui.screenshot()
        im_resize = im.resize((1920,1080))
        buf = io.BytesIO()
        im_resize.save(buf, format='PNG')
        byte_im = buf.getvalue()
        c.send(byte_im)
    elif data[0] == "terminate":
        terminate = True
    elif data[0] == "PrtScr":
        pyautogui.press("printscreen")
    else:
        pyautogui.press(data[0])

    # Close the connection with the client
    c.close()
    # print('Closed')

print('Server Stopped', end="\n")
