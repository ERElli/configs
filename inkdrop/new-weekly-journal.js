function getPreviousSunday(refDate) {
    const dayOfWeek = refDate.getDay();
    const daysSincePreviousSunday = refDate.getDate() - dayOfWeek;
    const previousSunday = new Date(refDate.setDate(daysSincePreviousSunday));
    return previousSunday;
}

function getNextSevenDaysFrom(refDate) {
    let daysOfWeek = [];
    daysOfWeek.push(refDate);
    for (let i = 1; i <= 6; i++) {
        const nextDay = new Date(daysOfWeek[i - 1]);
        nextDay.setDate(nextDay.getDate() + 1);
        daysOfWeek.push(nextDay);
    }
    return daysOfWeek;
}

function convertDateToFormattedString(date, format) {
    return new Intl.DateTimeFormat('en-ca', format).format(date);
}

const dailyTemplate = {
    personal: "### How did you feel this morning?\n### Goals for today\n### Reflections about the day\n",
    bluedrop: "### What are your goals today?\n### Log\n### Thoughts about the day\n",
};

module.exports = async ({ destinationNotebook = 'personal', weekOffset } = {}) => {
    const db = inkdrop.main.dataStore.getLocalDB();
    const template = await db.notes.get('note:lO04QEjO9');

    let startingSunday;
    if (weekOffset) {
        const previousSunday = getPreviousSunday(new Date());
        startingSunday = previousSunday
            .setDate(previousSunday.getDate() + 7 * weekOffset);
    }
    else {
        startingSunday = getPreviousSunday(new Date());
    }
    const dateFormat = { year: 'numeric', month: 'numeric', day: 'numeric', weekday: 'long' };
    const daysOfWeek = getNextSevenDaysFrom(startingSunday)
        .map((dayOfWeek) => convertDateToFormattedString(dayOfWeek, dateFormat))
        ;
    const title = `${daysOfWeek[0].split(',')[1].trim()} to ${daysOfWeek[6].split(',')[1].trim()}`
    const toc = daysOfWeek.reduce((acc, dayOfWeek) => {
        acc += `- [${dayOfWeek}](##${dayOfWeek.toLowerCase().replace(', ', '-')})\n`;
        return acc;
    }, '');
    const headers = daysOfWeek.reduce((acc, dayOfWeek) => {
        acc += `# ${dayOfWeek}\n`;
        acc += dailyTemplate[destinationNotebook];
        return acc;
    }, '');
    const body = toc + headers;
    const note = {
        ...template,
        _id: db.notes.createId(),
        _rev: undefined,
        title,
        body,
        createdAt: Date.now(),
        updatedAt: Date.now(),
    };

    delete note.tags;
    console.dir({ note }, { depth: 10 });
    try {
        await db.notes.put(note);
        await db.notes.get(note._id);
        inkdrop.commands.dispatch(
            document.body,
            'core:open-note',
            { noteId: note._id }
        );
    }
    catch (e) {
        console.log(e);
    }
}
