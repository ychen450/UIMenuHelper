TextFieldHelper
===============

iOS UITextField Helper
UIView+Textfield class and demos

##Features:
* Animating the view to make the edited text field visible.
* End editing and dismiss the keyboard by return key or tap outside the keyboard
* Return key type in sequence "Next" and "Go". "Next" goes to the next text field automatically.
* Validation including mininum length, maximun length, email, number only, and re-enter password check.

##How to use:
* Put UIView+Textfield class (.h and .m) into your project. Remember to #import "UIVew+Textfield.h" and <UITextFieldDelegate> when using.
* Set up in ViewDidLoad: (for example, your textfield is _userNameField and _passwordField)
      ```objc
      _userNameField.delegate = self;
      _passwordField.delegate = self;

      NSMutableDictionary *usernameDict = [[NSMutableDictionary alloc] init];
      [usernameDict setObject:_userNameField forKey:@"textfield"];
      [usernameDict setObject:[NSNumber numberWithInt:6] forKey:@"minlength"];                        // optional
      [usernameDict setObject:USERNAME_ERROR_SHORT forKey:@"minerror"];                               // optional
      [usernameDict setObject:[NSNumber numberWithInt:60] forKey:@"maxlength"];                       // optional
      [usernameDict setObject:USERNAME_ERROR_LONG forKey:@"maxerror"];                                // optional
      [usernameDict setObject:[NSString stringWithString:@"EMAIL"] forKey:@"validationoption"];       // optional
      [usernameDict setObject:[NSArray arrayWithObject:validationResult] forKey:@"validationlabel"];  // optional

      NSMutableDictionary *passwordDict = [[NSMutableDictionary alloc] init];
      [passwordDict setObject:_passwordField forKey:@"textfield"];
      [passwordDict setObject:[NSNumber numberWithInt:10] forKey:@"minlength"];                       // optional
      [passwordDict setObject:PASSWORD_ERROR_SHORT forKey:@"minerror"];                               // optional
      [passwordDict setObject:[NSArray arrayWithObject:validationResult] forKey:@"validationlabel"];  // optional

      NSArray *textfieldArray = [NSArray arrayWithObjects:usernameDict, passwordDict, nil];
      [self.view setTextField:textfieldArray];
      ```

    If validation needed,
      ```objc
      [[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(validateInputCallback:) 
                                             name:@"UITextFieldTextDidChangeNotification" 
                                           object:nil];
      ```

* Paste the following code outside of ViewDidLoad:
      ```objc
      - (BOOL)textFieldShouldReturn:(UITextField *)textField 
      {    
            [self.view textfieldReturn:textField];
            return NO;
      }
 
      - (void)textFieldDidBeginEditing:(UITextField *)textField
      {
            [self.view textfieldMakeVisible:textField];
      }
 
      - (void)textFieldDidEndEditing:(UITextField *)textField
      {
            [self.view textfieldEndEdit:textField];
      }
 
      - (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {   
            [self.view textfieldTouchToReturn];
      }
 
      - (void)validateInputCallback:(id)sender
      {
            if ([self.view validateInput]) {
                  _enrollButton.enabled = true;
            } else {
                  _enrollButton.enabled = false;
            }
      }
      ```

