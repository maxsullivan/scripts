# -*- coding: utf-8 -*-
"""
Created on Wed Dec  1 12:35:44 2021

This script loads a csv of titles and abstracts. It will load the first 40 rows using the nrow atribute.
It will loop through each row and classify the title and abstract into a 4 digit 2008 FoR code which is added
to the csv.

Output is saved as a CSV.

@author: sullivm1
"""

!pip install dimcli tqdm -U --quiet

import dimcli
from dimcli.utils import *

import sys, json, time, os
import pandas as pd
from tqdm.notebook import tqdm as pbar

dimcli.login()

dsl = dimcli.Dsl()

df = pd.read_csv("C:/Users/sullivm1/.dimensions/FOR-doctoral-388-500.csv", nrows=100, usecols=["title","abstract"])

pd.options.display.max_columns = None

df.head(5)

df['FoR_Categories'] = ''

# for index, row in df.iterrows():
for index, row in pbar(df.iterrows(), total=df.shape[0]):
    search_string = f"""
                    classify(title="{row.title}", abstract="{row.abstract}", system="FOR")
            """
    a = dsl.query(search_string, verbose=False)
    list_of_categories = []
    for x in a.json['FOR']:
        list_of_categories.append(x['name'])
    df['FoR_Categories'][index] = list_of_categories
    time.sleep(1)
#increase sleep

df.head(20)

df['Counts'] = ''
for index, row in df.iterrows():
    df['Counts'][index] = len(df['FoR_Categories'][index])

df['Counts'].value_counts().plot.bar(rot=0,
                                     title='Frequency of FoR counts',
                                     ylabel='Occurences',
                                     xlabel='Number of FoR categories')

df.to_csv(".dimensions\FOR-doctoral-output-388-500.csv", index=False)

dimcli.logout()
