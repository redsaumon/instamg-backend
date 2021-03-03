from django.shortcuts import render

def index(request):
    return render(request, 'direct_message/index.html')

def room(request, room_name):
    return render(request, 'direct_message/room.html', {
        'room_name': room_name
    })
