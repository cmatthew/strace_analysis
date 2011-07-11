'''
Created on 2011-05-30

@author: Caleb Shortt, TJ Borschneck
'''

dictionary = {}
commands = {}

class parser:
    
    def stripCommand(self, line):
        cmd = line
        start = line.find(" ")
        
        if start > 5 or start < 0:
            start = 0
        
        end = line.find("(")
        cmd = line[start:end]
        
        if cmd in commands:
            count = commands[cmd]
            count = count + 1
            commands[cmd] = count
        else:
            commands[cmd] = 1
    
    
    def runParser(self, filehandle):
        for line in filehandle:
            self.stripCommand(line)
            result = line
            eIndex = line.find(" =")
            if eIndex > 0:
                result = line[0:eIndex]
            
            if result in dictionary:
                count = dictionary[result]
                count = count + 1
                dictionary[result] = count
            else:
                dictionary[result] = 1
    

    def getData(self, filename):
        f = open(filename, 'r')
        return f
        
    
    def printDictionary(self):
        for k, v in dictionary.iteritems():
            print "%s : %s" % (k,v)
    
    def printCommands(self):
        for k,v in commands.iteritems():
            print "%s : \t\t%s" % (k, v)


if __name__ == '__main__':
    p = parser()
    f = raw_input("Enter the name of the file to be parsed: ")
    try:
        file = p.getData(f)
        p.runParser(file)
        print "\nTotal Commands Called (With Parameters):\n"
        p.printDictionary()
        print "\nTotal Commands Called:\n"
        p.printCommands()
    except:
        print "[ERROR] There was an error opening %s" % (f)
    
    




