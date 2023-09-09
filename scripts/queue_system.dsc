## - [ Nimnite Queue System ] - ##
fort_queue_handler:
  type: world
  debug: false
  events:

    on server start:
    - bossbar create fort_waiting color:YELLOW

    ## - [ QUEUE SYSTEM ] - ##
    on delta time secondly:

    - define min_players <script[nimnite_config].data_key[minimum_players]>
    - define max_players <script[nimnite_config].data_key[maximum_players]>

    - define players <server.online_players_flagged[fort]>

    - define players_not_queued <[players].filter[has_flag[fort.in_queue].not]>
    - define players_queued     <[players].filter[has_flag[fort.in_queue]]>

    # - Update Queue Timer
    #bossbar is created on player joins in "lobby.dsc"
    - foreach <[players_queued]> as:player:
      - define uuid <[player].uuid>
      - define seconds_in_queue <[player].flag[fort.in_queue]>

      - flag <[player]> fort.in_queue:++
      - define secs_in_queue <[player].flag[fort.in_queue]>

      - define match_info <[player].flag[fort.menu.match_info]>
      - adjust <[match_info]> "text:Finding match...<n>Elapsed: <time[2069/01/01].add[<[secs_in_queue]>].format[m:ss]>"

    - bossbar update fort_waiting title:<proc[spacing].context[50]><&chr[A004].font[icons]><proc[spacing].context[-72]><&l><element[WAITING FOR PLAYERS].font[lobby_text]> color:YELLOW players:<[players_queued].filter[has_flag[fort.in_menu].not]>
    #- foreach <[players_not_queued]> as:player:
      ############remove this
     # - if <[player].name> != Nimsy:
        #- stop

      #play the "play" glint animation
      #- run fort_lobby_handler.play_button_anim def.player:<[player]> if:<context.second.mod[10].equals[0]>


