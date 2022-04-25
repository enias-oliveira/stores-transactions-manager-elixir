import { Typography } from '@mui/material'
import axios from 'axios';
import type { NextPage } from 'next'
import Head from 'next/head'
import useSWR from 'swr';

const fetcher = (url: string) => axios.get(url).then(res => res.data);

const Home: NextPage = () => {
    const { data } = useSWR('http://strs-transactions-manager-dev.herokuapp.com/transactions', fetcher);

    if (!data) {
        return <div>...Loading</div>
    }

    return (
        <div>
            <Head>
                <title>Stores Transactions Manager</title>
                <link rel="icon" href="/favicon.ico" />
            </Head>

            <main >
                <Typography variant='h1'>
                    Stores Transactions Manager
                </Typography>

                <div>{data}</div>
            </main>

        </div>
    )
}

export default Home
