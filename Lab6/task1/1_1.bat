wmic os get caption > caption.txt
wmic computersystem get totalphysicalmemory > memory.txt
wmic os get freephysicalmemory >> memory.txt
wmic logicaldisk list brief > disks.txt
