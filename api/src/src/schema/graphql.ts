
/*
 * -------------------------------------------------------
 * THIS FILE WAS AUTOMATICALLY GENERATED (DO NOT MODIFY)
 * -------------------------------------------------------
 */

/* tslint:disable */
/* eslint-disable */

export class NewUserInput {
    email: string;
    password: string;
    name: string;
}

export class User {
    id: string;
    name: string;
    email: string;
    rooms?: Nullable<Nullable<ChatRoom>[]>;
    createdAt?: Nullable<Date>;
    updatedAt?: Nullable<Date>;
    friends?: Nullable<Nullable<User>[]>;
}

export class AuthPayload {
    token: string;
    refreshToken: string;
    user: User;
}

export class Message {
    id: string;
    text: string;
    user: User;
    createdAt?: Nullable<Date>;
    updatedAt?: Nullable<Date>;
}

export class ChatRoom {
    id: string;
    name: string;
    description: string;
    owner: User;
    users: User[];
    messages: Message[];
}

export abstract class IQuery {
    abstract user(id: string): User | Promise<User>;

    abstract test(): User[] | Promise<User[]>;

    abstract refresh(refreshToken?: Nullable<string>): AuthPayload | Promise<AuthPayload>;

    abstract getRooms(page?: Nullable<number>, limit?: Nullable<number>): ChatRoom[] | Promise<ChatRoom[]>;

    abstract getFriends(): User[] | Promise<User[]>;
}

export abstract class IMutation {
    abstract updateUser(id: string, name: string, email: string, password: string): User | Promise<User>;

    abstract deleteUser(id: string): User | Promise<User>;

    abstract login(email: string, password: string): AuthPayload | Promise<AuthPayload>;

    abstract signUp(data: NewUserInput): AuthPayload | Promise<AuthPayload>;

    abstract createRoom(name: string, description: string): ChatRoom | Promise<ChatRoom>;
}

type Nullable<T> = T | null;
