# Pair of coords (None if unused)
problem_number = 39
spacecrafts = {
    'Red': (5, 5),
    'Orange': (1, 1),
    'Yellow': (1, 3),
    'Green': (1, 5),
    'Blue': (3, 1),
    'Purple': (5, 1)
}

with open('lunar_lockout_template.pddl', mode='r') as pf:
    code = ''.join(pf.readlines())
    
    codified_at = []
    codified_empty = []

    for i in range(1, 6):
        for j in range(1, 6):
            occupied = False
            for s_name, s_coords in spacecrafts.items():
                if s_coords == (i, j):
                    occupied = True
                    codified_at.append(f'\t\t(at {s_name} C{i} C{j})')
            
            if not occupied:
                codified_empty.append(f'\t\t(empty C{i} C{j})')

    codified_problem = '\n'.join(codified_at) + '\n\n' + '\n'.join(codified_empty)

    code = code.replace(';@ SPECIFIC PROBLEM @;', codified_problem, 1)

    with open(f'lunar_lockout_{problem_number}.pddl', mode='w') as f:
        f.write(code)