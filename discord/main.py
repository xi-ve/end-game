import discord
from discord.ext import commands
import datetime
import mysql.connector
bot = commands.Bot(command_prefix='$')

dbh = mysql.connector.connect(host='localhost',database='bdo',user='root',password='')
cursor = dbh.cursor(prepared=True)
dbh.autocommit = True




tasks = list()
def check(user_id):
    ret = -1
    for x in range(len(tasks)):
        if user_id == tasks[x][0]:
            ret = x
            return ret
    return ret
@bot.event
async def on_ready():
    print('We have logged in as {0.user}'.format(bot))


@bot.command()
async def sub(ctx):
    query = 'SELECT l_exp FROM login WHERE l_discord = %s'
    cursor.execute(query, [ctx.author.id, ])
    l_exp = cursor.fetchone()[0]
    date_1 = datetime.datetime.now()
    if l_exp > date_1:
        embed = discord.Embed(color=0x00afb0)
        embed.add_field(name="You still got a valid subscription!", value="It will expire at: " + l_exp.strftime('%Y-%m-%d %H:%M:%S'), inline=False)
        
    else:
        embed = discord.Embed(color=0xFF0000)
        embed.add_field(name="You subscription has expired!", value="It expired at: " + l_exp.strftime('%Y-%m-%d %H:%M:%S'), inline=False)
        
    await ctx.send(embed=embed)
@bot.command()
async def add(ctx,user: discord.User,time,time_type):
    if time_type != "days" and time_type != "hours":
        await ctx.send("$add <@user> <time> <days|hours>")
        return
    await bot.get_channel(755541623437393971).send(f"<@{ctx.author.id}> ({ctx.author.id}) added {time} {time_type} to <@{user.id}> ({user.id})")
    await ctx.send(f"adding {time} {time_type} to {user.display_name}")
    query = 'SELECT COUNT(l_id) FROM login WHERE l_discord = %s'
    cursor.execute(query, [user.id, ])
    user_count = cursor.fetchone()[0]
    if user_count == 0:
        tasks.append([user.id,time,time_type])
        embed = discord.Embed(color=0x00afb0)
        embed.add_field(name="You got a subscription!", value="Please send me a username you would like to use in the loader.", inline=False)
        embed.set_footer(text=f"Duration: {time} {time_type}")
        await user.send(embed=embed)
    else:
        query = 'SELECT l_exp FROM login WHERE l_discord = %s'
        cursor.execute(query, [user.id, ])
        user_date = cursor.fetchone()[0]
        date_1 = datetime.datetime.now()
        if user_date > date_1:
            date_1 = user_date
        if time_type == "days":
            end_date = date_1 + datetime.timedelta(days=int(time))
        else:
            end_date = date_1 + datetime.timedelta(hours=int(time))

        query = "UPDATE `login` SET l_exp = %s WHERE l_discord = %s;"
        cursor.execute(query, [end_date.strftime('%Y-%m-%d %H:%M:%S'),user.id, ])
        embed = discord.Embed(color=0x00afb0)
        embed.add_field(name="You got a subscription!", value="We increased the time of the account linked to your discord.", inline=False)
        embed.set_footer(text=f"Duration: {time} {time_type} Expires: " + end_date.strftime('%Y-%m-%d %H:%M:%S'))
        await user.send(embed=embed)    
        await bot.get_channel(755541623437393971).send(f'<@{user.id}> ({user.id}) extended their subscription. expires at: '+ end_date.strftime('%Y-%m-%d %H:%M:%S'))
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
            if tasks[user][2] == "days":
                end_date = date_1 + datetime.timedelta(days=int(tasks[user][1]))
            else:
                end_date = date_1 + datetime.timedelta(hours=int(tasks[user][1]))
            query = 'SELECT COUNT(l_id) FROM login WHERE l_user = %s'
            cursor.execute(query, [message.content, ])
            user_count = cursor.fetchone()[0]
            if user_count != 0:
                embed = discord.Embed(color=0xFF0000)
                embed.add_field(name="Failed!", value="The registration failed, there is already a user with your name!", inline=False)
                await message.channel.send(embed=embed)
                return        
            query = "INSERT INTO `login` (`l_id`, `l_user`, `l_discord`, `l_pass`, `l_hwid`, `l_exp`, `l_banned`) VALUES (NULL, %s, %s, NULL, '', %s, NULL);"
            cursor.execute(query, [message.content,message.author.id,end_date.strftime('%Y-%m-%d %H:%M:%S'), ])
            embed = discord.Embed(color=0x00afb0)
            embed.add_field(name="Done!", value="You can now login into the Loader with your username!, The password you provide on your first login will be set!", inline=False)
            embed.set_footer(text="expires: " + end_date.strftime('%Y-%m-%d %H:%M:%S'))
            await message.channel.send(embed=embed)
            await bot.get_channel(755541623437393971).send(f'<@{message.author.id}> ({message.author.id}) registed with "{message.content}" as the username.Subscription expires at: '+ end_date.strftime('%Y-%m-%d %H:%M:%S'))
            tasks.pop(user)
    await bot.process_commands(message)
bot.run('NzU1NzgxMjQzMzc0NjY1NzI4.X2ISIg.f2YpVHcdnlqC5UV8aBTbwzz-eCU')
