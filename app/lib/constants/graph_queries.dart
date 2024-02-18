const loginMutation = r'''
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
        token,
        user {
            email,
            id,
            name
        }
    }
}
''';

const signupMutation = r'''
mutation signUp($email: String!, $password: String!, $name: String!) {
  signUp(data: {email:$email, password: $password, name:$name}) {
        token,
        user {
            email,
            id,
            name
        }
    }
}
''';

const getRoomsQuery = r'''
query GetRooms {
    getRooms {
        id
        name
        description
    }
}
''';
