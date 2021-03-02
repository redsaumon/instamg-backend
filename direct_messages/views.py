from django.shortcuts import render

def index(request):
    return render(request, 'direct_messages/index.html')

def room(request, room_name):
    return render(request, 'direct_messages/room.html', {
        'room_name': room_name
    })
