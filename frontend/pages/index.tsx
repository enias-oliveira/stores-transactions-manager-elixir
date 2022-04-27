import { Alert, CircularProgress, Container, Paper, Snackbar, Stack, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Typography } from '@mui/material';
import axios from 'axios';
import type { NextPage } from 'next';
import Head from 'next/head';
import { useState } from 'react';
import FileUpload from 'react-material-file-upload';
import useSWR, { useSWRConfig } from 'swr';
import { StoreRow } from '../components/StoreRow';

const storesApi = '/api/stores';

const fetcher = (url: string) => axios.get(url).then(res => res.data);

const Home: NextPage = () => {
    const { mutate } = useSWRConfig()
    const [successFeedbackOpen, setSuccessFeedbackOpen] = useState(false);


    const { data } = useSWR(storesApi, fetcher);

    const handleFileUpload = async (files: File[]) => {
        const [file] = files;

        const formData = new FormData();
        formData.append('file', file)

        await axios.post('/api/transactions/upload', formData, {
            headers: { 'content-type': 'multipart/form-data' },
        });

        setSuccessFeedbackOpen(true)
        mutate(storesApi)
    };

    return (
        <>
            <Head>
                <title>Stores Transactions Manager</title>
                <link rel="icon" href="/favicon.ico" />
            </Head>

            <Container maxWidth="lg" sx={{ mt: 1 }} >
                <header>
                    <Stack direction="row" alignItems="center" justifyContent="space-between" >
                        <Typography variant='h3' my={15}>
                            Stores Transactions Manager
                        </Typography>

                        <FileUpload value={[]} onChange={handleFileUpload} />

                        <Snackbar open={successFeedbackOpen}
                            autoHideDuration={6000}
                            onClose={() => setSuccessFeedbackOpen(false)}
                            anchorOrigin={{ vertical: 'top', horizontal: 'right' }} >
                            <Alert onClose={() => setSuccessFeedbackOpen(false)} severity="success">File Successfully Uploaded!</Alert>
                        </Snackbar>
                    </Stack>
                </header>

                <main >
                    <TableContainer component={Paper}>
                        {data ?
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
                            </Table> : <CircularProgress />
                        }

                    </TableContainer>
                </main>
            </Container>
        </>
    )
}

export default Home
