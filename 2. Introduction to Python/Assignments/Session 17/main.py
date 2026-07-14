
import playlist_utils
playlist = []
playlist_utils.add_song(playlist, "Perfect")
playlist_utils.add_song(playlist, "Believer")
playlist_utils.add_song(playlist, "Shape of You")

print("My Playlist:")
for song in playlist:
    print("-", song)