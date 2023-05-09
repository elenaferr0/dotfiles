import json
import subprocess as s

LENGTH = 69
ELLIPSIS_LENGTH = 40

def replace_newlines(line):
    line = line.rstrip('\n')
    line_len = len(line)
    if line_len < LENGTH:
        line = line + ' ' * (LENGTH - line_len)
    return line

def ellipse_string(string):
    if len(string) <= ELLIPSIS_LENGTH:
        return string
    return string[:ELLIPSIS_LENGTH-3] + '...'

def get_dunst_history():
    history = s.run("dunstctl history", shell=True, stdout=s.PIPE).stdout
    json_notifications = json.loads(history.decode('utf-8'))['data'][0]
    
    markup_notifications = [] 
    for notification in json_notifications:
        author = notification['summary']['data']
        content = ellipse_string(notification['body']['data'])

        markup_notifications.append(f'<span><b>{author}</b>: {content}</span>')
    return len(json_notifications), '\n'.join(markup_notifications) 

notifications_count, tooltip = get_dunst_history() 
out = {"tooltip": replace_newlines(tooltip), "percentage": notifications_count}
print(json.dumps(out))
