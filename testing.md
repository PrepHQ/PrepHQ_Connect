# Testing!

## Using Travis CI for Automated Testing

![](images/travis-ci.png)

[Travis CI](https://travis-ci.com/github/PrepHQ/PrepHQ_Connect) is the continuous integration service we use to implement automated testing on code merges and pull request creation. It is free for open source projects on GitHub. It is super helpful in ensuring that all of our code merges do not break existing tests. The tests have to pass before we merge in code.

## Test Cases

Here are some brief descriptions of all of our current test cases!

### [General UI Tests](https://github.com/PrepHQ/PrepHQ_Connect/blob/master/test/general_ui_test.dart)

#### Validate login screen widgets initialize correctly
#### Validate registration screen widgets initialize correctly
#### Validate navigation to registration page from login screen works
#### Validate that Mentor Home widgets are initialized
#### Validate that Mentor Screen widget constructs all three mentor tabs

### [Unit Tests](https://github.com/PrepHQ/PrepHQ_Connect/blob/master/test/unit_test.dart)

#### isCompleted should be marked true when complete is called
#### Setting name of student works
#### Setting name of mentor works
#### Create correct list of time slots using getTimes function
#### Validate getTime behavior
#### Validate getDate behavior

### [Widget Tests](https://github.com/PrepHQ/PrepHQ_Connect/blob/master/test/widget_test.dart)

#### Validate AppBarActionBtn constructs as expected
#### Test that article card constructs as expected
#### Test that the first card of weekly gridview is the current day
#### Validate that MeetingHeaderItems constructs as expected

[Back to Main Site](https://prephq.github.io/PrepHQ_Connect/)