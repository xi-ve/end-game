import discord
from discord.ext import commands,tasks
import datetime
import asyncio
import mysql.connector
bot = commands.Bot(command_prefix='$')

dbh = mysql.connector.connect(host='localhost',database='cheat',user='root',password='')
cursor = dbh.cursor(prepared=True)
dbh.autocommit = True




tasks_todo = list()
def check(user_id):
    ret = -1
    for x in range(len(tasks_todo)):
        if user_id == tasks_todo[x][0]:
            ret = x
            return ret
    return ret
@bot.event
async def on_ready():
    print('We have logged in as {0.user}'.format(bot))


@bot.command()
async def sub(ctx):
    query = 'SELECT s_name,e_exp FROM exp,login,soft WHERE exp.l_id = login.l_id AND exp.e_exp > now() AND exp.s_id = soft.s_id AND login.l_discord = %s'
    cursor.execute(query, [ctx.author.id, ])
    l_exp = cursor.fetchall()
    data = "Name\tExpires\n"
    if len(l_exp) > 0:
        for x in l_exp:
            data += str(x[0]) + "\t" + str(x[1]) + "\n" 
        await ctx.send(data)
    else:
        await ctx.send("no valid sub")

@bot.command()
async def ban(ctx,user: discord.Member,reason):
    query = "UPDATE `login` SET l_banned = %s WHERE l_discord = %s;"
    cursor.execute(query, [reason,user.id, ])
    await ctx.send("done....")
    await bot.get_channel(755541623437393971).send(f'<@{ctx.author.id}> ({ctx.author.id}) banned <@{user.id}> ({user.id}) for following reason {reason}')


@bot.command()
async def get_soft(ctx):
    query = 'SELECT s_name FROM soft'
    cursor.execute(query)
    soft = cursor.fetchall()
    for s in soft:
        await ctx.send(s[0])
@bot.command()
async def add(ctx,user: discord.Member,software,time,time_type):
    if time_type != "days" and time_type != "hours":
        await ctx.send("$add <@user> <soft> <time> <days|hours>")
        return
    query = 'SELECT COUNT(s_id) FROM soft WHERE s_name = %s'
    cursor.execute(query, [software, ])
    soft_count = cursor.fetchone()[0]
    if soft_count == 0:
        await ctx.send("$add <@user> <soft> <time> <days|hours>")
        return
    role = discord.utils.get(ctx.guild.roles, name="member+")
    await user.add_roles(role)
    await bot.get_channel(755541623437393971).send(f"<@{ctx.author.id}> ({ctx.author.id}) added {software} {time} {time_type} to <@{user.id}> ({user.id})")
    await ctx.send(f"adding {time} {time_type} to {user.display_name}")
    query = 'SELECT COUNT(l_id) FROM login WHERE l_discord = %s'
    cursor.execute(query, [user.id, ])
    user_count = cursor.fetchone()[0]
    if user_count == 0:
        tasks_todo.append([user.id,software,time,time_type])
        embed = discord.Embed(color=0x00afb0)
        embed.add_field(name=f"You got a {software} subscription!", value="Please send me a username you would like to use in the loader.", inline=False)
        embed.set_footer(text=f"Duration: {time} {time_type}")
        await user.send(embed=embed)
    else:
        query = 'SELECT exp.e_id,exp.e_exp FROM exp,login,soft WHERE exp.l_id = login.l_id AND exp.s_id = soft.s_id AND login.l_discord = %s AND soft.s_name = %s'
        cursor.execute(query, [user.id,software, ])
        user_date = cursor.fetchone()
        exp_index = user_date[0]
        user_date = user_date[1]
        date_1 = datetime.datetime.now()
        if user_date > date_1:
            date_1 = user_date
        if time_type == "days":
            end_date = date_1 + datetime.timedelta(days=int(time))
        else:
            end_date = date_1 + datetime.timedelta(hours=int(time))

        query = "UPDATE `exp` SET e_exp = %s WHERE e_id = %s;"
        cursor.execute(query, [end_date.strftime('%Y-%m-%d %H:%M:%S'),exp_index, ])
        embed = discord.Embed(color=0x00afb0)
        embed.add_field(name="You got a subscription!", value="We increased the time of the account linked to your discord.", inline=False)
        embed.set_footer(text=f"Duration: {time} {time_type} Expires: " + end_date.strftime('%Y-%m-%d %H:%M:%S'))
        await user.send(embed=embed)    
        await bot.get_channel(755541623437393971).send(f'<@{user.id}> ({user.id}) extended their {software} subscription. expires at: '+ end_date.strftime('%Y-%m-%d %H:%M:%S'))
    return

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return
    if isinstance(message.channel, discord.channel.DMChannel):
        user = check(message.author.id)
        if user == -1:
            return
        else:
            date_1 = datetime.datetime.now()
            if tasks_todo[user][3] == "days":
                end_date = date_1 + datetime.timedelta(days=int(tasks_todo[user][2]))
            else:
                end_date = date_1 + datetime.timedelta(hours=int(tasks_todo[user][2]))
            query = 'SELECT COUNT(l_id) FROM login WHERE l_user = %s'
            cursor.execute(query, [message.content, ])
            user_count = cursor.fetchone()[0]
            if user_count != 0:
                embed = discord.Embed(color=0xFF0000)
                embed.add_field(name="Failed!", value="The registration failed, there is already a user with your name!", inline=False)
                await message.channel.send(embed=embed)
                return        
            query = "INSERT INTO `login` (`l_id`, `l_user`, `l_discord`, `l_pass`, `l_hwid`, `l_banned`) VALUES (NULL, %s, %s, NULL, '', NULL);"
            cursor.execute(query, [message.content,message.author.id, ])
            user_index = cursor.lastrowid
            query = 'SELECT s_id FROM soft WHERE s_name = %s'
            cursor.execute(query, [tasks_todo[user][1], ])
            soft_index = cursor.fetchone()[0]
            query = "INSERT INTO `exp` (`e_id`, `l_id`, `s_id`, `e_exp`) VALUES (NULL, %s, %s, %s);"
            cursor.execute(query, [user_index,soft_index,end_date.strftime('%Y-%m-%d %H:%M:%S'), ])
            embed = discord.Embed(color=0x00afb0)
            embed.add_field(name="Done!", value="You can now login into the Loader with your username!, The password you provide on your first login will be set!", inline=False)
            embed.set_footer(text="expires: " + end_date.strftime('%Y-%m-%d %H:%M:%S'))
            await message.channel.send(embed=embed)
            await bot.get_channel(755541623437393971).send(f'<@{message.author.id}> ({message.author.id}) registed with "{message.content}" as the username.Subscription expires at: '+ end_date.strftime('%Y-%m-%d %H:%M:%S'))
            tasks_todo.pop(user)
    await bot.process_commands(message)


async def name_change():
    await bot.wait_until_ready()
    while True:
        query = 'SELECT l_discord, count(e_id) FROM login LEFT JOIN exp ON login.l_id = exp.l_id AND exp.e_exp > now() GROUP BY l_discord'
        cursor.execute(query)
        exp_user = cursor.fetchall()
        for x in exp_user:
            if x[1] > 0:
                continue
            user_id = x[0]
            member = discord.utils.get(bot.get_guild(755527342054441130).members, id=user_id)
            if member is not None: 
                role = discord.utils.get(bot.get_guild(755527342054441130).roles, name="member+")
                await member.remove_roles(role)

        query = 'SELECT l_discord FROM login WHERE l_banned <> ""'
        cursor.execute(query)
        exp_user = cursor.fetchall()
        for x in exp_user:
            user_id = x[0]
            member = discord.utils.get(bot.get_guild(755527342054441130).members, id=user_id)
            if member is not None:
                role = discord.utils.get(bot.get_guild(755527342054441130).roles, name="member+")
                await  member.remove_roles(role)
                await  member.ban()
        
        await asyncio.sleep(60)

bot.loop.create_task(name_change())
bot.run('NzU1NzgxMjQzMzc0NjY1NzI4.X2ISIg.f2YpVHcdnlqC5UV8aBTbwzz-eCU')
