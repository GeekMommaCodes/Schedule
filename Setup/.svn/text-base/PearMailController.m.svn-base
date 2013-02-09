//
//  PearMailController.m
//  Schedule
//
//  Created by Sven Bär on 18.05.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//
/*
#import "PearMailController.h"

@implementation PearMailController


-(void)displayAlert {  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fehler melden." message:@"Vielen Dank für die Meldung. Wir werden den Fehler mit dem nächsten Update beheben." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];  
    [alert show];    
}  


-(void)sendMail{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Bug"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"baer@pear-it.de", nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"Have you seen the MobileTuts+ web site?";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the drafts folder.");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
			break;
		default:
			NSLog(@"Mail not sent.");
			break;
	}
    
    // Remove the mail view
	[self dismissModalViewControllerAnimated:YES];
}


@end
*/