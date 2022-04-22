export const RAW_TRANSACTIONS_TIME_OFFSET = 3; // Transactions Time in Txt File are in UTC-3, check README

export enum CNAB_TRANSACTIONS_SPEC {
    TYPE = 0,
    DATE_START = 1,
    DATE_END = 9,
    TIME_START = 42,
    TIME_END = 48,
    VALUE_START = 9,
    VALUE_END = 19,
    CPF_START = 19,
    CPF_END = 30,
    CARD_START = 30,
    CARD_END = 42,
    STORE_OWNER_START = 48,
    STORE_OWNER_END = 62,
    STORE_NAME_START = 62,
    STORE_NAME_END = 81,
}