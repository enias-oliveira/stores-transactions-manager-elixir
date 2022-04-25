import { Container, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography } from '@mui/material';
import axios from 'axios';
import type { NextPage } from 'next';
import Head from 'next/head';
import useSWR from 'swr';
import { StoreRow } from '../components/StoreRow';

const fetcher = (url: string) => axios.get(url).then(res => res.data);

const Home: NextPage = () => {
    const { data } = useSWR('/api/stores', fetcher);

    if (!data) {
        return <div>...Loading</div>
    }

    return (
        <>
            <Head>
                <title>Stores Transactions Manager</title>
                <link rel="icon" href="/favicon.ico" />
            </Head>

            <main >
                <Container maxWidth="lg" >
                    <Typography variant='h3' my={3}>
                        Stores Transactions Manager
                    </Typography>

                    <TableContainer component={Paper}>
                        <Table aria-label="collapsible table">
                            <TableHead>
                                <TableRow>
                                    <TableCell></TableCell>
                                    <TableCell>Store</TableCell>
                                    <TableCell>Owner</TableCell>
                                </TableRow>
                            </TableHead>
                            <TableBody>
                                {data.map((store: { name: string, owner: string, id: number }) => (<StoreRow key={store.id} store={store} />))}
                            </TableBody>
                        </Table>
                    </TableContainer>
                </Container>
            </main>
        </>
    )
}

export default Home
