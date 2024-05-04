const generateWeeklyJournal = require('./new-weekly-journal');

inkdrop.commands.add(
    document.body,
    'custom:new-weekly-personal-journal',
    async () => generateWeeklyJournal()
);

inkdrop.commands.add(
    document.body,
    'custom:new-weekly-personal-journal-next-week',
    async () => generateWeeklyJournal({ weekOffset: 1 })
);

inkdrop.commands.add(
    document.body,
    'custom:new-weekly-work-journal',
    async () => generateWeeklyJournal({destinationNotebook: 'bluedrop'})
);

inkdrop.commands.add(
    document.body,
    'custom:new-weekly-work-journal-next-week',
    async () => generateWeeklyJournal({ destinationNotebook: 'bluedrop', weekOffset: 1 })
);

inkdrop.menu.add([
    {
        label: 'File',
        submenu: [
            {
                label: 'Weekly Journals',
                submenu: [
                    {
                        label: 'Create a personal journal for this week',
                        command: 'custom:new-weekly-personal-journal'
                    }
                ]
            }
        ]
    },
    {
        label: 'File',
        submenu: [
            {
                label: 'Weekly Journals',
                submenu: [
                    {
                        label: 'Create a personal journal for next week',
                        command: 'custom:new-weekly-personal-journal-next-week'
                    }
                ]
            }
        ]
    },
    {
        label: 'File',
        submenu: [
            {
                label: 'Weekly Journals',
                submenu: [
                    {
                        label: 'Create a work journal for this week',
                        command: 'custom:new-weekly-work-journal'
                    }
                ]
            }
        ]
    },
    {
        label: 'File',
        submenu: [
            {
                label: 'Weekly Journals',
                submenu: [
                    {
                        label: 'Create a work journal for next week',
                        command: 'custom:new-weekly-work-journal-next-week'
                    }
                ]
            }
        ]
    }
])
