import { Typography } from '@mui/material'
import type { NextPage } from 'next'
import Head from 'next/head'

const Home: NextPage = () => {
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
            </main>

        </div>
    )
}

export default Home
