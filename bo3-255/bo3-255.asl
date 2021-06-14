state("blackops3")
{
	byte round_counter : 0x1140FC30;
    byte is_paused : 0x3480E08; // No clue if this is actually the pause variable, but it seems to work as if it is
    string13 currentMap : 0x179E1840;
}

startup
{
    vars.timer_start = 0;
    vars.round_splits = new int[] {5, 10, 15, 20, 25, 30, 50, 70, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 255};
    vars.split_index = 0;
}

start
{
    if(current.round_counter == 0)vars.timer_start = 0;
    if(current.round_counter == 1 && vars.timer_start == 0)
    {
        vars.timer_start = 1;
        return true;
    }
}

reset
{
    if(current.round_counter == 0 && old.round_counter != 0) return true;
    if(current.map_name.Equals("core_frontend")) return true;
    return false;
}

isLoading
{
    if(current.is_paused == 1) return true;
    return false;
}

split
{
    if(current.round_counter == vars.round_splits[vars.split_index])
    {
        vars.split_index++;
        return true;
    }
}