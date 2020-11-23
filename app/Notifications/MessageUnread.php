<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Neo\PusherBeams\PusherBeams;
use Neo\PusherBeams\PusherMessage;
use App\User;
use App\Model\Message;

class MessageUnread extends Notification
{
    use Queueable;

    public $user;
    public $message;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct(User $user, Message $message)
    {
        $this->user = $user;
        $this->message = $message;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return [PusherBeams::class];
    }



    public function toPushNotification($notifiable)
    {
        return PusherMessage::create()
            ->iOS()
            ->android()
            ->platform('web')
            ->sound('success')
            ->title('SIMPLEVISOR')
            ->body("<bold>{$this->user->firstName} {$this->user->lastName}</bold> <hr> {$this->message->message}")
            ->setOption('apns.aps.mutable-content', 1);
    }

    public function pushNotificationInterest()
    {
        $id = $this->message->id;

        $audience = strtolower($this->user->id);

        return "message_{$id}-pushed by_{$audience}";
    }
}
