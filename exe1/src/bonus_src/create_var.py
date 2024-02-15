
print("signal", end=' ')
for i in range(1, 35):
    print(f"c{i}i, c{i}i,")

print("==================")
for i in range(1, 35):
    print(f"U{i}: hacky_add5 port map(binin=>c{i}i, binout=>c{i}o);")
