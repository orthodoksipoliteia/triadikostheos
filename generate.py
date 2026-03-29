# coding: utf8

import random
import os

proseuxi = ['Κύριε Ιησού Χριστέ, ελέησον με', 'Δόξα σοι ὁ Θεός']
#print(random.choice(proseuxi))

#dataset = random.randint(1000000000,9999999999)
#os.mkdir("datasets/" + str(dataset))

loopCounter = random.randint(100,1000)

for x in range(loopCounter):
    sentence = random.choice(proseuxi)
    print(sentence)
