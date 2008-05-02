#IFNDEF __SATISFY__
#ERROR Must compile neverassist.bi
#ELSE
/'
 ' Welcome to the construction blocks source file.
 '/
declare sub place_block
sub place_block
    /'
     ' BlockType is the type of the block you're using.
     '
     ' BlockSet is the set of blocks you're using.
     '
     ' Start is exclusive to the start block. It allows you to place the block
     ' once.
     '
     ' XP is the X Position of the assistant's cursor.
     '
     ' YP is the Y Position of the assistant's cursor. It's requirement is
     ' also exclusive to the start block.
     '
     ' ZP is the Z Position of the assistant's cursor.
     '
     ' Money is the current amount of money you expended. MaxMoney is the
     ' maximum you can spend. This maximum applies to every map made with the
     ' assistant.
     '
     ' PlacementTest prevents you from overriding blocks with each other.
     '/

    if (BlockType = 1) AND (BlockSet = 0) AND (Start = 0) AND (YP < 10) AND _
        PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        /'
         ' Increments the entity ID.
         '/
        Entity += 1
        /'
         ' Plots the brush(es) into a seperate worldspawn entity.
         '
         ' The plot_face subroutine has 11 arguments. They're listed in the
         ' neverassist.bi header file.
         '/
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
        plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
        plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
        plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
        plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        print #m, "}"

        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"arrow-green-light")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"

        /'
         ' This entity serves a different purpose. In this case, its the
         ' starting point.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                  "info_player_start"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "& YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"
        /'
         ' This provides the first part of the initial camera.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                  "info_player_intermission"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "& YP*128-64;" "& ZP*64+224;chr(34)
        print #m, chr(34)+"target"+chr(34)+" "+chr(34)+"goal"+chr(34)
        print #m, "}"

        /'
         ' Once the file has been written, the program then records the
         ' details into its own memory.
         '/
        Start = 1
        PlacementTest(PlacementFormula) = 1
        place_gfx(0)
        LevelTime += 150
        MinimumLevelTime += 50
        Blocks += 1
        Openings += 1
        Putt = 2

    elseif (BlockType = 2) AND (BlockSet = 0) AND (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        /'
         ' Rotations is how the appearance of the blocks can differ.
         '
         ' However, the block above (start block) is the only block that can't
         ' be rotated. You always start facing north, and the start block
         ' always faces north.
         '/
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end if
        print #m, "}"
        print #m, "}"
        PlacementTest(PlacementFormula) = 2
        place_gfx(0)
        LevelTime += 100
        MinimumLevelTime += 75
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 3) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"

        /'
         ' This allows more flexibility in printing the blocks with the
         ' appropriate textures. However, the block above it would not be
         ' different for certain rotations, which is why its merged together.
         '
         ' This block does have it all different.
         '/
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        PlacementTest(PlacementFormula) = 3
        place_gfx(0)
        LevelTime += 200
        MinimumLevelTime += 150
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 4) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        PlacementTest(PlacementFormula) = 4
        place_gfx(0)
        LevelTime += 300
        MinimumLevelTime += 200
        Money += 1
        Blocks += 1
        Openings += 1
        Putt = 2

    elseif (BlockType = 5) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        /'
         ' This is the cross block. It would be the same no matter how you
         ' rotate it. As a result, there are no internal statements keeping
         ' what's below from printing to the file.
         '/
        plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
        plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
        plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
        plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
        plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
        print #m, "}"
        print #m, "}"
        PlacementTest(PlacementFormula) = 5
        place_gfx(0)
        LevelTime += 400
        MinimumLevelTime += 300
        Blocks += 1
        Openings += 2
        Putt = 2

    elseif (BlockType = 6) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end if
        print #m, "}"
        print #m, "}"

        /'
         ' Four yellow coins.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 6
        place_gfx(0)
        LevelTime += 175
        MinimumLevelTime += 125
        TargetCoins += 1
        Coins += 4
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 7) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 7
        place_gfx(0)
        LevelTime += 275
        MinimumLevelTime += 200
        TargetCoins += 1
        Coins += 4
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 8) AND (BlockSet = 0) AND (Openings > 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"

        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        PlacementTest(PlacementFormula) = 8
        place_gfx(0)
        LevelTime += 50
        Blocks += 1
        Money += 1
        Openings -= 1
        Putt = 2

    elseif (BlockType = 9) AND (BlockSet = 0) AND (Openings > 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"

        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 9
        place_gfx(0)
        LevelTime += 150
        MinimumLevelTime += 100
        TargetCoins += 1
        Coins += 4
        Blocks += 1
        Money += 1
        Openings -= 1
        Putt = 2

    elseif (BlockType = 10) AND (BlockSet = 0) AND _
           (Money + 2 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-128,0,0,0,0,0,0,-16,16,"yellow")
            plot_face(0,0,0,0,-128,0,0,0,0,-16,"invisible")
            plot_face(0,0,0,64,0,0,-64,0,-16,64,"yellow")
            plot_face(0,-128,-16,-16,0,-16,-16,-128,0,-16,"yellow")
            plot_face(0,-128,-16,-64,-128,-16,64,0,-16,64,"yellow")
            plot_face(0,-128,-16,-64,-128,0,-64,-128,-16,64,"yellow")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,0,0,0,0,-128,0,-16,-128,16,"yellow")
            plot_face(0,0,0,16,-16,0,16,0,0,-16,"yellow")
            plot_face(0,0,-128,0,0,0,0,0,-128,-16,"invisible")
            plot_face(0,-16,-128,-16,0,-128,-16,-16,-64,-16,"yellow")
            plot_face(0,-16,-128,-16,-16,-128,16,0,-128,-16,"yellow")
            plot_face(0,-16,-128,-16,-16,-64,-16,-16,-128,16,"yellow")
        end if
        print #m, "}"

        /'
         ' Notice how this "lump" is present as well. This block is two lumps.
         ' More lumps means a greater complexity of the block.
         '/
        print #m, "// brush 1"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,0,-128,0,-128,-128,0,-128,-112,16,"yellow")
            plot_face(0,0,-112,64,-128,-112,64,0,-112,-64,"yellow")
            plot_face(0,0,-112,64,0,-112,-64,0,-128,64,"yellow")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,-112,-16,"yellow")
            plot_face(0,-128,-128,0,0,-128,0,0,-128,-16,"invisible")
            plot_face(0,-128,-128,-64,-128,-112,-64,-128,-128,64,"yellow")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-128,-128,0,-128,0,0,-112,-128,16,"yellow")
            plot_face(0,-112,0,16,-128,0,16,-112,0,-16,"yellow")
            plot_face(0,-112,-64,16,-112,-64,-16,-112,-128,16,"yellow")
            plot_face(0,-128,-128,-16,-112,-128,-16,-128,-64,-16,"yellow")
            plot_face(0,-128,-128,-16,-128,-128,16,-112,-128,-16,"yellow")
            plot_face(0,-128,0,0,-128,-128,0,-128,0,-16,"invisible")
        end if
        print #m, "}"
        print #m, "}"

        PlacementTest(PlacementFormula) = 10
        place_gfx(0)
        LevelTime += 350
        MinimumLevelTime += 200
        Money += 2
        Blocks += 1
        Putt = 2

    elseif (BlockType = 11) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"
        print #m, "}"

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 11
        place_gfx(0)
        LevelTime += 425
        MinimumLevelTime += 300
        TargetCoins += 1
        Coins += 4
        Blocks += 1
        Money += 1
        Openings += 1
        Putt = 2

    elseif (BlockType = 12) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"coin-green-small")
        plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
        plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
        plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
        plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
        print #m, "}"
        print #m, "}"

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+24;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 12
        place_gfx(0)
        LevelTime += 575
        MinimumLevelTime += 400
        TargetCoins += 1
        Coins += 4
        Blocks += 1
        Money += 1
        Openings += 2
        Putt = 2

    elseif (BlockType = 13) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 AND _
            PlacementTest(PlacementFormula+2000) = 0 then
        /'
         ' This is the first block to take more than one space.
         '
         ' It also takes the space right above it.
         '/

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"

        select case Rotation
            case 1
                plot_face(0,-128,0,64,0,0,64,0,-128,0,"turf-green")
                plot_face(0,-128,0,48,0,0,48,0,0,64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,0,0,48,-128,0,48,0,-128,-16,"turf-grey")
                plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 2
                plot_face(0,0,0,64,0,-128,64,-128,-128,0,"turf-green")
                plot_face(0,0,0,0,-128,0,0,0,0,-16,"turf-grey")
                plot_face(0,0,0,48,0,-128,48,0,-128,64,"invisible")
                plot_face(0,0,-128,48,0,0,48,-128,-128,-16,"turf-grey")
                plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-128,0,0,0,0,0,0,-128,64,"turf-green")
                plot_face(0,0,0,0,-128,0,0,0,0,-16,"invisible")
                plot_face(0,0,-128,0,0,0,0,0,-128,-16,"turf-grey")
                plot_face(0,0,0,-16,-128,0,-16,-128,-128,48,"turf-grey")
                plot_face(0,0,-128,48,-128,-128,48,-128,-128,64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,0,0,0,0,-128,0,-128,-128,64,"turf-green")
                plot_face(0,0,0,0,-128,0,0,0,0,-16,"turf-grey")
                plot_face(0,0,-128,0,0,0,0,0,-128,-16,"invisible")
                plot_face(0,-128,0,48,-128,-128,48,0,-128,-16,"turf-grey")
                plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,48,-128,0,48,-128,0,64,"invisible")
        end select
        print #m, "}"
        print #m, "}"
        PlacementTest(PlacementFormula) = 13
        PlacementTest(PlacementFormula+2000) = 13
        place_gfx(0)
        place_gfx(2000)
        LevelTime += 150
        MinimumLevelTime += 75
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 14) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-128,-64,16,0,-64,16,0,-128,0,"turf-green")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            plot_face(0,0,-64,16,-128,-64,16,0,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-64,-128,16,-64,0,16,0,0,0,"turf-green")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,-64,0,16,-64,-128,16,-128,0,0,"turf-green")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
        end if
        print #m, "}"
        print #m, "}"
        PlacementTest(PlacementFormula) = 15
        place_gfx(0)
        LevelTime += 125
        MinimumLevelTime += 75
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 15) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-128,-64,16,0,-64,16,0,-128,0,"coin-green-small")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            plot_face(0,0,-64,16,-128,-64,16,0,0,0,"coin-green-small")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-64,-128,16,-64,0,16,0,0,0,"coin-green-small")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,-128,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,-64,0,16,-64,-128,16,-128,0,0,"coin-green-small")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
        end if
        print #m, "}"
        print #m, "}"

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-96;" "& ZP*64+32;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-96;" "& ZP*64+32;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                  " "& YP*128-32;" "& ZP*64+32;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"light"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                  " "& YP*128-32;" "& ZP*64+32;chr(34)
        print #m, chr(34)+"light"+chr(34)+" "+chr(34)+"1"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 15
        place_gfx(0)
        LevelTime += 225
        MinimumLevelTime += 150
        TargetCoins += 1
        Coins += 4
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 16) AND (BlockSet = 0) AND _
           (Money + 3 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end if
        print #m, "}"
        print #m, "}"

        /'
         ' Even trains can be utilized in this assistant. I should expand this,
         ' however, to allow all directions. It doesn't do this yet.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"func_train"+chr(34)
        print #m, chr(34)+"target"+chr(34)+" "+chr(34)+"path_corner"; _
                  ""& Entity+1;chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-64,-32,64,-64,-96,64,-128,-32,64,"turf-grey")
            plot_face(0,-64,-32,16,-128,-32,16,-64,-32,0,"turf-grey")
            plot_face(0,-64,-32,16,-64,-32,0,-64,-96,16,"turf-grey")
            plot_face(0,-128,-96,0,-64,-96,0,-128,-32,0,"turf-grey")
            plot_face(0,-128,-96,0,-128,-96,16,-64,-96,0,"turf-grey")
            plot_face(0,-128,-96,0,-128,-32,0,-128,-96,16,"turf-grey")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-32,0,64,-32,-64,64,-96,0,64,"turf-grey")
            plot_face(0,-32,0,16,-96,0,16,-32,0,0,"turf-grey")
            plot_face(0,-32,0,16,-32,0,0,-32,-94,16,"turf-grey")
            plot_face(0,-96,-64,0,-32,-64,0,-96,0,0,"turf-grey")
            plot_face(0,-96,-64,0,-96,-64,16,-32,-64,0,"turf-grey")
            plot_face(0,-96,-64,0,-96,0,0,-96,-64,16,"turf-grey")
        end if
        print #m, "}"
        print #m, "}"

        /'
         ' Uses the entities needed for the mover.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"path_corner"+chr(34)
        if (Rotation = 1) OR (Rotation = 3) then
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-32; _
                      " "& YP*128-64;" "& ZP*64-16;chr(34)
        elseif (Rotation = 2) OR (Rotation = 4) then
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-96;" "& ZP*64-16;chr(34)
        end if
        print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"path_corner"; _
                  ""& Entity-1;chr(34)
        print #m, chr(34)+"target"+chr(34)+" "+chr(34)+"path_corner"; _
                  ""& Entity;chr(34)
        print #m, chr(34)+"speed"+chr(34)+" "+chr(34)+"3"+chr(34)
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"path_corner"+chr(34)
        if (Rotation = 1) OR (Rotation = 3) then
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-96; _
                      " "& YP*128-64;" "& ZP*64-16;chr(34)
        elseif (Rotation = 2) OR (Rotation = 4) then
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-32;" "& ZP*64-16;chr(34)
        end if
        print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"path_corner"; _
                  ""& Entity-1;chr(34)
        print #m, chr(34)+"target"+chr(34)+" "+chr(34)+"path_corner"; _
                  ""& Entity-2;chr(34)
        print #m, chr(34)+"speed"+chr(34)+" "+chr(34)+"3"+chr(34)
        print #m, "}"

        PlacementTest(PlacementFormula) = 2
        place_gfx(0)
        LevelTime += 325
        MinimumLevelTime += 150
        Money += 3
        Blocks += 2
        Putt = 2

    elseif (BlockType = 17) AND (BlockSet = 0) AND _
           (Money + 3 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        /'
         ' This block has a narrow center.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,0,16,0,0,-128,0,-128,16,0,"turf-green-dark")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,16,-16,"turf-grey")
            plot_face(0,-48,-96,-16,0,-128,-16,-128,16,-16,"turf-grey")
            plot_face(0,-80,-96,0,-80,-96,0,-80,-32,0,"turf-grey")
            plot_face(0,-48,-32,-16,-48,-32,0,-80,-32,0,"invisible")
            plot_face(0,-80,-96,-16,-80,-96,0,-48,-96,0,"invisible")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,0,0,0,0,-128,0,-128,0,0,"turf-green-dark")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-80,-80,64,-48,-80,-64,-80,-80,-64,"turf-grey")
            plot_face(0,-96,-64,64,-96,-80,-64,-96,-64,-64,"invisible")
            plot_face(0,-32,-64,-64,-32,-80,-64,-32,-64,64,"invisible")
            plot_face(0,-96,-48,-64,-64,-48,-64,-96,-48,64,"turf-grey")
        end if
        print #m, "}"
        print #m, "// brush 1"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,0,16,0,0,-128,0,-128,16,0,"turf-green-dark")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,16,-16,"turf-grey")
            plot_face(0,-80,-32,0,-80,-32,-16,-128,0,-16,"turf-grey")
            plot_face(0,-48,-32,-16,-48,-32,0,0,0,0,"turf-grey")
            plot_face(0,-48,-32,0,-48,-32,-16,-80,-32,-16,"invisible")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,0,0,0,0,-128,0,-128,0,0,"turf-green-dark")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-16,-128,0,-16,-128,-128,0,"invisible")
            plot_face(0,-96,-48,64,-128,0,-64,-96,-48,-64,"turf-grey")
            plot_face(0,-96,-64,-64,-96,-80,-64,-96,-64,64,"invisible")
            plot_face(0,-96,-80,-64,-128,-128,-64,-96,-80,64,"turf-grey")
        end if
        print #m, "}"
        /'
         ' It takes three lumps to form a block that is narrow in the middle.
         '/
        print #m, "// brush 2"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,0,16,0,0,-128,0,-128,16,0,"turf-green-dark")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,16,-16,"invisible")
            plot_face(0,-80,-96,-16,-80,-96,0,-128,-128,0,"turf-grey")
            plot_face(0,-48,-96,0,-48,-96,-16,0,-128,-16,"turf-grey")
            plot_face(0,-80,-96,0,-80,-96,-16,-48,-96,-16,"invisible")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,0,0,0,0,-128,0,-128,0,0,"turf-green-dark")
            plot_face(0,0,0,0,0,0,-16,0,-128,0,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-32,-80,64,0,-128,-64,-32,-80,-64,"turf-grey")
            plot_face(0,-32,-64,64,-32,-80,-64,-32,-64,-64,"invisible")
            plot_face(0,0,0,64,-32,-48,-64,0,0,-64,"turf-grey")
        end if
        print #m, "}"
        print #m, "}"
        PlacementTest(PlacementFormula) = 17
        place_gfx(0)
        LevelTime += 100
        MinimumLevelTime += 75
        Money += 3
        Blocks += 3
        Putt = 2

    elseif (BlockType = 22) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then

        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        if (Rotation = 1) OR (Rotation = 3) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        elseif (Rotation = 2) OR (Rotation = 4) then
            plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
            plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
            plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
            plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
            plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
            plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end if

        /'
         ' Notice that the brush below is completely detail. What makes
         ' it so is the first argument of plot_face. See neverassist.bi
         ' for more information.
         '/
        print #m, "}"
        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"goal")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" " + _
                  chr(34)+"info_player_deathmatch"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "&YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"

        /'
         ' This is the finish touch of our initial camera. This is only placed
         ' the first time you place a finish block. There is no limit to the
         ' number of finish blocks.
         '/
        if Finish = 0 then
            print #m, "// entity ";Entity;"
            Entity += 1
            print #m, "{"
            print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                      "target_position"+chr(34)
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-64;" "& ZP*64+128;chr(34)
            print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"goal"+chr(34)
            print #m, "}"
        end if
        PlacementTest(PlacementFormula) = 22
        place_gfx(0)
        LevelTime += 125
        MinimumLevelTime += 100
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 23) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"

        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"goal")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" " + _
                  chr(34)+"info_player_deathmatch"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "&YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"

        if Finish = 0 then
            print #m, "// entity ";Entity;"
            Entity += 1
            print #m, "{"
            print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                      "target_position"+chr(34)
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-64;" "& ZP*64+128;chr(34)
            print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"goal"+chr(34)
            print #m, "}"
        end if

        PlacementTest(PlacementFormula) = 23
        place_gfx(0)
        LevelTime += 225
        MinimumLevelTime += 175
        Money += 1
        Blocks += 1
        Putt = 2

    elseif (BlockType = 24) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select
        print #m, "}"

        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"goal")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" " + _
                  chr(34)+"info_player_deathmatch"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "&YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"

        if Finish = 0 then
            print #m, "// entity ";Entity;"
            Entity += 1
            print #m, "{"
            print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                      "target_position"+chr(34)
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-64;" "& ZP*64+128;chr(34)
            print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"goal"+chr(34)
            print #m, "}"
        end if
        PlacementTest(PlacementFormula) = 24
        place_gfx(0)
        LevelTime += 325
        MinimumLevelTime += 225
        Money += 1
        Blocks += 1
        Openings += 1
        Putt = 2

    elseif (BlockType = 25) AND (BlockSet = 0) AND _
           (Money + 1 < = MaxMoney) AND _
            PlacementTest(PlacementFormula) = 0 then
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
        plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
        plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
        plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
        plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
        plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
        print #m, "}"

        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"goal")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" " + _
                  chr(34)+"info_player_deathmatch"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "&YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"

        if Finish = 0 then
            print #m, "// entity ";Entity;"
            Entity += 1
            print #m, "{"
            print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                      "target_position"+chr(34)
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-64;" "& ZP*64+128;chr(34)
            print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"goal"+chr(34)
            print #m, "}"
        end if
        PlacementTest(PlacementFormula) = 25
        place_gfx(0)
        LevelTime += 425
        MinimumLevelTime += 325
        Blocks += 1
        Openings += 2
        Putt = 2

    elseif (BlockType = 26) AND (BlockSet = 0) AND (Openings > 0) AND _
            PlacementTest(PlacementFormula) = 0 then
        /'
         ' I didn't put a money statement on this block because it doesn't
         ' cost any. However, you must have a free opening.
         '/
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" "+chr(34)+"worldspawn"+chr(34)
        print #m, "// brush 0"
        print #m, "{"
        select case Rotation
            case 1
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"invisible")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 2
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"invisible")
            case 3
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"invisible")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"turf-grey")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
            case 4
                plot_face(0,-16,0,0,-16,-128,0,-144,0,0,"turf-green")
                plot_face(0,0,0,64,-128,0,64,0,0,-64,"turf-grey")
                plot_face(0,0,0,64,0,0,-64,0,-128,64,"invisible")
                plot_face(0,-128,-128,-16,0,-128,-16,-128,0,-16,"turf-grey")
                plot_face(0,-128,-128,-64,0,-128,64,0,-128,-64,"turf-grey")
                plot_face(0,-128,-128,-64,-128,0,-64,-128,-128,64,"turf-grey")
        end select

        print #m, "}"
        print #m, "// brush 1"
        print #m, "{"
        plot_face(1,-16,0,1,-16,-128,1,-144,0,1,"goal")
        plot_face(1,0,0,80,-128,0,80,0,0,-48,"invisible")
        plot_face(1,0,0,80,0,0,-48,0,-128,80,"invisible")
        plot_face(1,-128,-128,0,0,-128,0,-128,0,0,"invisible")
        plot_face(1,-128,-128,-48,0,-128,79,0,-128,-48,"invisible")
        plot_face(1,-128,-128,-48,-128,0,-49,-128,-128,80,"invisible")
        print #m, "}"
        print #m, "}"
        print #m, "// entity ";Entity;"
        Entity += 1
        print #m, "{"
        print #m, chr(34)+"classname"+chr(34)+" " + _
                  chr(34)+"info_player_deathmatch"+chr(34)
        print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                  " "&YP*128-64;" "& ZP*64+24;chr(34)
        print #m, "}"

        if Finish = 0 then
            print #m, "// entity ";Entity;"
            Entity += 1
            print #m, "{"
            print #m, chr(34)+"classname"+chr(34)+" "+chr(34) + _
                      "target_position"+chr(34)
            print #m, chr(34)+"origin"+chr(34)+" "+chr(34)& XP*128-64; _
                      " "& YP*128-64;" "& ZP*64+128;chr(34)
            print #m, chr(34)+"targetname"+chr(34)+" "+chr(34)+"goal"+chr(34)
            print #m, "}"
        end if

        PlacementTest(PlacementFormula) = 26
        place_gfx(0)
        LevelTime += 150
        MinimumLevelTime += 50
        Blocks += 1
        Finish += 1
        Openings -= 1
        Putt = 2
    end if
end sub
#ENDIF