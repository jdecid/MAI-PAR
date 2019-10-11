import time
import tkinter as tk

from generator import spacecrafts


class GameBoard(tk.Frame):
    def __init__(self, parent, rows=5, columns=5, size=50):
        self.rows = rows
        self.columns = columns
        self.size = size

        self.ships = {}
        self.pieces = {}

        canvas_width = columns * size
        canvas_height = rows * size

        tk.Frame.__init__(self, parent)
        self.canvas = tk.Canvas(self,
                                borderwidth=0,
                                highlightthickness=0,
                                width=canvas_width,
                                height=canvas_height,
                                background='bisque')

        self.canvas.pack(side='top', fill='both', expand=True, padx=2, pady=2)
        self.canvas.bind('<Configure>', self.refresh)

        self.winfo_toplevel().title('Lunar Lockout')

    def add_piece(self, name, row=0, column=0):
        self.canvas.create_oval(0, 0, self.size - 10, self.size - 10,
                                outline='black', fill=name, tags=('piece', name))
        self.place_piece(name, row, column)

    def place_piece(self, name, row, column):
        self.pieces[name] = (row, column)
        x0 = (column * self.size) + 5
        y0 = (row * self.size) + 5
        self.canvas.coords(name, x0, y0, x0 + self.size - 10, y0 + self.size - 10)

    def refresh(self, event):
        x_size = int((event.width - 1) / self.columns)
        y_size = int((event.height - 1) / self.rows)
        self.size = min(x_size, y_size)
        self.canvas.delete('square')
        for row in range(self.rows):
            for col in range(self.columns):
                x1 = (col * self.size)
                y1 = (row * self.size)
                x2 = x1 + self.size
                y2 = y1 + self.size
                bg_color = '#FF9991' if (row == 2) and (col == 2) else '#CFCFC4'
                self.canvas.create_rectangle(x1, y1, x2, y2, outline='black', fill=bg_color, tags='square')
        for name in self.pieces:
            self.place_piece(name, self.pieces[name][0], self.pieces[name][1])

        self.canvas.tag_raise('piece')
        self.canvas.tag_lower('square')


if __name__ == '__main__':
    root = tk.Tk()
    board = GameBoard(root)
    board.pack(side='top', fill='both', expand='true', padx=4, pady=4)

    for spacecraft_name, coords in spacecrafts.items():
        board.add_piece(spacecraft_name.lower(), coords[0] - 1, coords[1] - 1)

    root.update_idletasks()
    root.update()

    with open('plan.txt', mode='r') as f:
        lines = f.readlines()
        for idx, line in enumerate(lines):
            action = line.strip().split(': (move-')[1][:-1]
            direction, spacecraft, _, _, cell = action.split()
            if direction == 'up' or direction == 'down':
                new_coords = (int(cell[-1]) - 1, board.pieces[spacecraft][1])
            else:
                new_coords = (board.pieces[spacecraft][0], int(cell[-1]) - 1)

            print(f'Step {idx:2}: move {spacecraft} to {new_coords}')
            board.place_piece(spacecraft, new_coords[0], new_coords[1])

            root.update_idletasks()
            root.update()

            time.sleep(1)

    root.mainloop()
