import pandas as pd
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.corpus import brown
from collections import Counter


#Run this in the first Run
#nltk.download('stopwords')
#nltk.download('punkt')
#nltk.download('brown')

#Uses the English words from the stopword library
stop_words = set(stopwords.words('english'))
#Uses the brown corpus library ~ 1 mill
brown_words = set(brown.words())

word_freq = Counter(brown_words)

# Select the 500 most common words
common_words = [word for word, freq in word_freq.most_common(500)]

#adds brown words to stop_words
stop_words.update(common_words)

#Custom Words, add your own
custom_stop_words = ["support", "sexual", "New York", "new york", "new", "york", "New", "York","Connecticut","Massachusetts", "gender", "salary", "range", "race", "color", "including", "national", "origin", "ability", "experience", "requirements", "using", 'the', 'and', 'in', 'to', 'for', 'with', 'a', 'an', 'of', 'on', 'at',
    'is', 'as', 'by', 'from', 'within', 'under', 'over', 'through', 'its',
    'your', 'you', 'our', 'we', 'will', 'be', 'or', 'that', 'this', 'such',
    'such as', 'including', 'include', 'require', 'requirements', 'requirement',
    'job', 'position', 'role', 'title', 'description', 'responsibilities',
    'responsibility', 'company', 'work', 'salary', 'compensation',
    'benefits', 'benefit', 'qualification', 'qualifications', 'qualify',
    'experience', 'level', 'industry', 'location', 'employment', 'contract',
    'full-time', 'part-time', 'time', 'contractor', 'location', 'location(s)',
    'years', 'months', 'days', 'skills', 'skill', 'knowledge', 'ability',
    'abilities', 'years', 'months', 'days', 'etc', 'etc.', 'apply', 'apply now',
    'apply today', 'apply online', 'apply via', 'contact', 'email', 'phone',
    'address', 'send', 'resume', 'cv', 'cover letter', 'cover', 'letter', 'send',
    'click', 'here', 'click here', 'please', 'apply via', 'get', 'in', 'by', 
    'at', 'salary', 'include', 'position', 'company', 'year', 'new', 'must',
    'candidates', 'company', 'employee', 'candidates', 'experience', 'new',
    'candidates', 'employee', 'job', 'jobs', 'employee', 'employer', 'years',
    'position', 'employee', 'candidates', 'apply', 'applying', 'years', 'offer',
    'posting', 'hiring', 'hire', 'job', 'opportunity', 'today', 'join', 'employment',
    'new', 'employee', 'candidates', 'including', 'candidates', 'employee', 'candidates',
    'successful', 'candidates', 'join', 'team', 'offer', 'including', 'including', 'qualified', "Support", "Sexual", "New York", "New York", "New", "York", "New", "York", "Connecticut",
    "Massachusetts", "Gender", "Salary", "Range", "Race", "Color", "Including", "National",
    "Origin", "Ability", "Experience", "Requirements", "Using", 'The', 'And', 'In', 'To', 'For',
    'With', 'A', 'An', 'Of', 'On', 'At', 'Is', 'As', 'By', 'From', 'Within', 'Under', 'Over',
    'Through', 'Its', 'Your', 'You', 'Our', 'We', 'Will', 'Be', 'Or', 'That', 'This', 'Such',
    'Such As', 'Including', 'Include', 'Require', 'Requirements', 'Requirement', 'Job', 'Position',
    'Role', 'Title', 'Description', 'Responsibilities', 'Responsibility', 'Company', 'Work',
    'Salary', 'Compensation', 'Benefits', 'Benefit', 'Qualification', 'Qualifications', 'Qualify',
    'Experience', 'Level', 'Industry', 'Location', 'Employment', 'Contract', 'Full-Time', 'Part-Time',
    'Time', 'Contractor', 'Location', 'Location(s)', 'Years', 'Months', 'Days', 'Skills', 'Skill',
    'Knowledge', 'Ability', 'Abilities', 'Years', 'Months', 'Days', 'Etc', 'Etc.', 'Apply', 'Apply Now',
    'Apply Today', 'Apply Online', 'Apply Via', 'Contact', 'Email', 'Phone', 'Address', 'Send', 'Resume',
    'CV', 'Cover Letter', 'Cover', 'Letter', 'Send', 'Click', 'Here', 'Click Here', 'Please', 'Apply Via',
    'Get', 'In', 'By', 'At', 'Salary', 'Include', 'Position', 'Company', 'Year', 'New', 'Must', 'Candidates',
    'Company', 'Employee', 'Candidates', 'Experience', 'New', 'Candidates', 'Employee', 'Job', 'Jobs',
    'Employee', 'Employer', 'Years', 'Position', 'Employee', 'Candidates', 'Apply', 'Applying', 'Years',
    'Offer', 'Posting', 'Hiring', 'Hire', 'Job', 'Opportunity', 'Today', 'Join', 'Employment', 'New', 'Employee',
    'Candidates', 'Including', 'Candidates', 'Employee', 'Candidates', 'Successful', 'Candidates', 'Join', 'Team',
    'Offer', 'Including', 'Including', 'Qualified']

# Adds custom list to the total list.
stop_words.update(custom_stop_words)

#To see the full list of removed words
#print(stop_words)

#Add columns you want
columns_to_read = ["description"]

# Read the CSV, Add the csv file here
df = pd.read_csv('jobsNewYork.csv', usecols=columns_to_read)

#Removes any special characters
df['description'] = df['description'].str.replace(r'[^a-zA-Z\s]', '', regex=True)

# Tokenize the "description" column
df['description'] = df['description'].apply(lambda x: word_tokenize(x))

#removes stopwords from description
def remove_stop_words(words):
    filtered_words = []
    for word in words:
        if word.lower() not in stop_words:
            filtered_words.append(word)
    return filtered_words

df['description'] = df['description'].apply(remove_stop_words)

# Convert the first letter of each word to uppercase
df['description'] = df['description'].apply(lambda words: [word.title() for word in words])

#Converts to csv file
df.to_csv('NewYorkcleaned.csv', index=False)

print(df, "Success") 
