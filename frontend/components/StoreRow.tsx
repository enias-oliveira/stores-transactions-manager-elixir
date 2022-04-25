import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import { Collapse, IconButton, TableCell, TableRow } from '@mui/material';
import { DataGrid, GridColDef } from '@mui/x-data-grid';
import axios from 'axios';
import { useState } from 'react';
import useSWR from 'swr';

const fetcher = (url: string) => axios.get(url).then(res => res.data);

interface StoreRowPropTypes {
    store: {
        id: number
        name: string
        owner: string
    }
}

const StoreRow = ({ store }: StoreRowPropTypes) => {
    const [open, setOpen] = useState(false);
    const { data } = useSWR(() => open ? `http://localhost:5500/stores/${store.id}/transactions` : null, fetcher);

    const transactionsColumns: GridColDef[] = [
        {
            field: "id",
            headerName: "TransactionId",
            flex: 1,
        },
        {
            field: "date",
            flex: 1,
        },
        {
            field: "value",
            flex: 1,
        },
        {
            field: "CPF",
            flex: 1,
        },
        {
            field: "card",
            flex: 1,
        },
    ];

    return (
        <>
            <TableRow sx={{ '&& > *': { borderBottom: 'unset' } }} >
                <TableCell>
                    <IconButton
                        aria-label="expand row"
                        size="small"
                        onClick={() => setOpen(!open)}
                    >
                        {open ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
                    </IconButton>
                </TableCell>
                <TableCell>{store.name}</TableCell>
                <TableCell>{store.owner}</TableCell>
            </TableRow>
            <TableRow>
                <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={3}>
                    <Collapse in={open} timeout="auto" unmountOnExit>
                        {data &&
                            <DataGrid
                                columns={transactionsColumns}
                                rows={data}
                                autoHeight
                                sx={{ mb: 3 }}
                            />
                        }
                    </Collapse>
                </TableCell>
            </TableRow>
        </>
    );
};

export { StoreRow };
