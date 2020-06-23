import tkinter
import os


def create_window():
    window = tkinter.Tk()
    window.title("Text Compare")
    window.geometry('600x600')
    return window


def main():
    win = create_window()

    # Set the text windows size
    txt1 = tkinter.Text(win, width=45, height=20)
    txt1.pack()

    txt2 = tkinter.Text(win, width=45, height=20)
    txt2.pack()

    msg1 = ''
    msg2 = ''

    # Save the input text into tmp files
    # the assembly program will read from these two files
    # and then compare the difference
    tmp_file1 = 'files/file1.txt'
    tmp_file2 = 'files/file2.txt'


    def display():
        # Read lines from row 0 to 1000 and column 0 to 1000
        msg1 = txt1.get('0.0', '255.1000')
        msg2 = txt2.get('0.0', '255.1000')

        # '#' token is the end of file flag, which is my own idea - -
        with open(tmp_file1, 'w') as f:
            f.write(msg1 + '#')

        with open(tmp_file2, 'w') as f:
            f.write(msg2 + '#')

        print("Here is the different lines:")
        os.system('./exe')
        print()


    button = tkinter.Button(win, text="compare different line", command=display)
    button.pack()

    win.mainloop()

if __name__ == "__main__":
    main()
