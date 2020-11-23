require('./bootstrap');

Echo.private('user')
    .listen('MessageSent', (e) => {
        this.messages.push({
            message: e.message.message,
            user: e.user
        });
    });
