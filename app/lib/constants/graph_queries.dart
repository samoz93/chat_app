const loginMutation = r'''
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
        token,
        refreshToken,
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

const refreshTokenQuery = r'''
query Refresh($refreshToken: String!) {
    refresh(refreshToken: $refreshToken) {
        token
        user {
            id
            name
            email
            createdAt
            updatedAt
            friends {
              id
              name
            }
            rooms {
                id
                name
            }
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

const friendsQuery = r'''
  query getFriends {
      getFriends {
          id
          name
      }
  }
''';
